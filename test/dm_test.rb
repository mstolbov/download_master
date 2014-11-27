# Run tests:
# $ ruby -Ilib:test test/dm_test.rb

require './test/test_helper'

class TestDM < Minitest::Test
  def setup
    stub_start_page
  end

  def test_input_validation_url
    url = "www/images"
    assert_raises DM::BadURI do
      DM.process(url)
    end
  end

  def test_simple
    url = "https://www.test.host/images"
    page = DM.process(url)
    assert_equal "200", page.code
  end

end
