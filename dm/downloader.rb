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
        respond = c.request_get("#{uri.path}?#{uri.query}")

        case respond
        when Net::HTTPSuccess, Net::HTTPRedirection
          on_success respond, path, uri
        else
          on_error respond
        end

      end
    end

    private

      def on_success(respond, path, uri)
        filename = File.basename uri.path
        filename.gsub!(/[^0-9A-Za-z.\-]/, '_')
        File.open File.join(path, filename), "w" do |f|
          f.puts respond.body
        end
      end

      def on_error(respond)
        #log fail
      end

  end

end
