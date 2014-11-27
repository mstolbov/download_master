# Run tests:
# $ ruby -Ilib:test test/dm_test.rb

require './test/test_helper'

class DMTest < Minitest::Test
  def setup
    stub_start_page
  end

  #def test_simple
    #url = "https://www.test.host/images"
    #page = DM.process(url)
    #assert_equal "200", page.code
  #end

  def test_input_validation_url
    url = "www/images"
    assert_raises DM::BadURI do
      DM.process(url)
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

end
