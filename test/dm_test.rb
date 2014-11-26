# Run tests:
# $ ruby -Ilib:test test/test_dm.rb

require './test/test_helper'

class TestDM < Minitest::Test
  def setup
    stub_start_page
  end

  def test_simple
    url = "https://www.test.host/images"
    page = DM.process(url)
    assert_equal "200", page.code
  end

end
