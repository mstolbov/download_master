require 'net/http'
require 'uri'
require 'nokogiri'

class DM
  class BadURI < RuntimeError; end

  attr_reader :base_uri

  class << self
    def process(url, options = {})
      new(url, options).perform
    end
  end

  def initialize(url, options)
    raise BadURI unless valid_url?(url)

    @base_uri = URI.parse url
    @options = {
      download_path: "/dev/null",
      stack_size: 1
    }.merge(options)
  end

  def perform
    resp = connection.get("#{base_uri.path}?#{base_uri.query}")
    # if success
    images_urls resp.body
  end

  def images_urls(page)
    urls = []
    n_page = Nokogiri::HTML page
    n_page.xpath("//img").each do |img|
      img_src = img.attribute("src")
      if img_src

        if valid_url?(img_src.value)
          urls << img_src.value
        else
          puts img_src
          puts URI.join(base_uri, img_src.value)
          urls << URI.join(base_uri, img_src.value).to_s
        end

      end
    end
    urls
  end

  private

    def connection
      return @connection if @connection

      @connection = Net::HTTP.new(base_uri.host, base_uri.port)
      @connection.use_ssl = true if base_uri.scheme.eql?("https")
      @connection
    end

    def valid_url?(url)
      url =~ URI::regexp
    end
end
