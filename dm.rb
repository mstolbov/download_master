require 'net/http'
require 'uri'

class DM
  require './dm/parser'

  class BadURI < RuntimeError; end

  attr_reader :page_uri

  class << self
    def process(url, options = {})
      new(url, options).perform
    end
  end

  def initialize(url, options)
    raise BadURI unless url =~ URI::regexp

    @page_uri = URI.parse url
    @options = {
      timeout: 100,
      download_path: "/dev/null",
      stack_size: 1
    }.merge(options)
  end

  def perform
    resp = connection.get("#{page_uri.path}?#{page_uri.query}")

    case resp
    when Net::HTTPSuccess
      images_urls resp.body
    end
  end

  def images_urls(page)
    parser = Parser.new page_uri, page
    parser.images_urls
  end

  private

    def connection
      return @connection if @connection

      @connection = Net::HTTP.new(page_uri.host, page_uri.port)
      @connection.use_ssl = true if page_uri.scheme.eql?("https")
      @connection.continue_timeout = @options[:timeout]
      @connection
    end

end
