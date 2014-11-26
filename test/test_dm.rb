# Run tests:
# $ ruby -Ilib:test test/test_dm.rb

require "minitest/autorun"
require "./dm"

class TestDM < Minitest::Test
  def setup
    @url = "https://www.google.ru/search?q=funbox&newwindow=1&espv=2&biw=1177&bih=682&source=lnms&tbm=isch&sa=X&ei=J0t2VN-gF8mGywPwzYGYAQ&ved=0CAYQ_AUoAQ"
  end

  def test_simple
    page = DM.process(@url)
    assert_equal "200", page.code
  end

end
