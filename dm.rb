require 'uri'
require 'net/http'
require 'resolv-replace'
require 'logger'

class DM
  require './dm/parser'
  require './dm/downloader'

  class InvalidURI < RuntimeError; end
  class InvalidDownloadPath < RuntimeError; end
  class ConnectionError < RuntimeError; end

  attr_reader :page_uri

  class << self
    def start(url, options = {})
      new(url, options).perform

    rescue InvalidURI, InvalidDownloadPath => e
      logger.error e.message
      logger.error e.backtrace.join("\n")

      raise e
    end

    def logger
      @@logger ||= Logger.new('dm.log')
    end
  end

  def initialize(url, options)
    @options = {
      timeout: 100,
      download_path: Dir.pwd,
      stack_size: 1
    }.merge(options)

    raise InvalidDownloadPath unless Dir.exists?(@options[:download_path])
    raise InvalidURI unless url =~ URI::regexp

    @page_uri = URI.parse url

  end

  def perform
    respond = connection.request_get("#{page_uri.path}?#{page_uri.query}")

    case respond
    when Net::HTTPSuccess, Net::HTTPRedirection
      on_success respond
    else
      on_error respond
    end

  rescue ConnectionError => e
    logger.error e.message
    logger.error e.backtrace.join("\n")

    raise e
  end

  private

    def on_success(respond)
      logger.info "Success load page #{@page_uri}"
      urls = images_urls respond.body
      threads = []

      until urls.empty? do
        next_load_urls_part = urls.pop(@options[:stack_size])

        threads << Thread.new(next_load_urls_part) do |load_urls|
          downloader = DM::Downloader.new(load_urls, @options[:download_path], logger, {timeout: @options[:timeout]})
          downloader.start
        end
      end
      threads.each {|thr| thr.join }
    end

    def on_error(respond)
      raise ConnectionError.new("FAIL! Get url: #{@page_uri}. Respond #{respond.code} - #{respond.body}")
    end

    def images_urls(page)
      parser = Parser.new page_uri, page
      parser.images_urls
    end

    def connection
      return @connection if @connection

      @connection = Net::HTTP.new(page_uri.host, page_uri.port)
      @connection.use_ssl = true if page_uri.scheme.eql?("https")
      @connection.continue_timeout = @options[:timeout]
      @connection
    end

    def logger
      self.class.logger
    end

end
