require 'uri'
require 'net/http'
require 'resolv-replace'

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
  end

  private

    def on_success(respond)
      images_urls respond.body
    end

    def on_error(respond)
      raise ConnectionError.new("Try get url: #{@page_uri}. Respond #{respond.code} - #{respond.body}")
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

end
