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
    }.merge(optinos)
  end

  def perform
    h = Net::HTTP.new(uri.host, uri.port)
    h.use_ssl = true if uri.scheme.eql?("https")
    resp = h.get("#{uri.path}?#{uri.query}")
    puts resp.code
    puts resp.message
  end
end

# FIXME: move to tests
DM.process "https://www.google.ru/search?q=funbox&newwindow=1&espv=2&biw=1177&bih=682&source=lnms&tbm=isch&sa=X&ei=J0t2VN-gF8mGywPwzYGYAQ&ved=0CAYQ_AUoAQ"
