# Run tests:
# $ ruby -Ilib:test test/dm_test.rb

require './test/test_helper'

class DMTest < Minitest::Test
  def setup
    stub_start_url_200
  end

  def test_success
    stub_download_files_list_200
    Dir.mkdir "/tmp/dm"

    url = "https://www.test.host/images"
    DM.start(url, download_path: "/tmp/dm")

    sleep 1
    load_files = Dir["/tmp/dm/**/*"]
    assert !load_files.empty?

    system("rm -rf /tmp/dm")
  end

  def test_bad_respond
    stub_start_url_502

    url = "https://www.badtest.host/images"
    assert_raises DM::ConnectionError do
      DM.start(url)
    end
  end

  def test_invalid_url
    url = "bad/url"
    assert_raises DM::InvalidURI do
      DM.start(url)
    end
  end

  def test_invalid_download_path
    url = "https://www.test.host/images"
    options = {download_path: "/wrong/path/to/save"}
    assert_raises DM::InvalidDownloadPath do
      DM.start(url, options)
    end
  end

  describe "DM::Parser" do
    def setup
      uri = URI("https://www.test.host/images")
      page = load_fixrute("start_page.html")
      parser = DM::Parser.new(uri, page)
      @urls = parser.images_urls
    end

    def test_get_images_urls
      assert_equal 21, @urls.count
    end

    def test_get_given_url_hosted_images_urls
      assert_equal "https://www.test.host/textinputassistant/tia.png", @urls.first
    end

    def test_get_other_images_urls
      assert_equal "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTo_Hs0UKab5CfbOq4A4iQiZNgHLZeb4_sNfHPJdP599pcW0LvbncejJtYb", @urls.last
    end
  end

  describe "DM::Downloader" do
    def setup
      @urls = ["http://www.test.host/image.png"]
      @path = "/tmp"
      @logger = Logger.new(STDOUT)

      stub_download_file_200
    end

    def test_download_file
      downloader = DM::Downloader.new @urls, @path, @logger
      downloader.start

      assert File.exists?("/tmp/image.png")

      File.delete("/tmp/image.png")
    end
  end

end
