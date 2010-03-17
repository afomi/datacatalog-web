require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  
  def setup
    @controller = ApplicationController.new
  end
  
  test "simple error hash" do
    h = { 'frequency' => ['is invalid'] }
    expected = "<p>frequency</p><ul><li>is invalid</li></ul>"
    assert_equal expected, @controller.send(:build_error_message, h)
  end

  test "more complex error hash" do
    h = { 'password' => ['is too short', 'has invalid characters'] }
    expected = "<p>password</p><ul><li>is too short</li><li>has invalid characters</li></ul>"
    assert_equal expected, @controller.send(:build_error_message, h)
  end

end
