require "test_helper"

class JudgeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get judge_index_url
    assert_response :success
  end
end
