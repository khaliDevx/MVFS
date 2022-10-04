require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get add_emoployee" do
    get admin_add_emoployee_url
    assert_response :success
  end
end
