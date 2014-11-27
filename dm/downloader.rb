require 'uri'
require 'net/http'
require 'resolv-replace'

class DM::Downloader
  class << self

    def start(urls, path, timeout = 100)
      urls.each do |url|
        uri = URI(url)

        c = Net::HTTP.new(uri.host, uri.port)
        c.use_ssl = true if uri.scheme.eql?("https")
        c.continue_timeout = timeout
        resp = c.request_get("#{uri.path}?#{uri.query}")
        resp.body

        filename = File.basename uri.path
        #File.write File.join(path, filename)
      end
    end

  end

end
