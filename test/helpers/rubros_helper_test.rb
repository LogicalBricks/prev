require 'test_helper'

class RubrosHelperTest < ActionView::TestCase
  test "should convert markdown to HTML" do
    assert_match /<em>hola<\/em>/, markdown("_hola_")
  end
end
