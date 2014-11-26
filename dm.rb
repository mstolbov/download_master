require 'net/http'
require 'uri'

class DM

  attr_reader :uri

  class << self
    def process(url, options = {})
      new(url, options).perform
    end
  end

  def initialize(url, options)
    #FIXME: Validate url! Should have scheme!
    @uri = URI.parse url
    @options = {
      download_path: "/dev/null",
      stack_size: 1
    }.merge(options)
  end

  def perform
    h = Net::HTTP.new(uri.host, uri.port)
    h.use_ssl = true if uri.scheme.eql?("https")
    resp = h.get("#{uri.path}?#{uri.query}")
    resp
  end
end
