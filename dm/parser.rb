require 'uri'
require 'nokogiri'

class DM::Parser

  def initialize(page_uri, page)
    @page_uri = page_uri
    @raw_page = page
    @page = Nokogiri::HTML page
  end

  def images_urls
    urls = []
    @page.xpath("//img").each do |img|
      img_src = img.attribute("src")
      if img_src

        if img_src.value =~ URI::regexp
          urls << img_src.value
        else
          urls << URI.join(@page_uri, img_src.value).to_s
        end

      end
    end
    urls
  end

end
