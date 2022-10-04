require "test_helper"

class FixedIssuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fixed_issue = fixed_issues(:one)
  end

  test "should get index" do
    get fixed_issues_url
    assert_response :success
  end

  test "should get new" do
    get new_fixed_issue_url
    assert_response :success
  end

  test "should create fixed_issue" do
    assert_difference("FixedIssue.count") do
      post fixed_issues_url, params: { fixed_issue: {  } }
    end

    assert_redirected_to fixed_issue_url(FixedIssue.last)
  end

  test "should show fixed_issue" do
    get fixed_issue_url(@fixed_issue)
    assert_response :success
  end

  test "should get edit" do
    get edit_fixed_issue_url(@fixed_issue)
    assert_response :success
  end

  test "should update fixed_issue" do
    patch fixed_issue_url(@fixed_issue), params: { fixed_issue: {  } }
    assert_redirected_to fixed_issue_url(@fixed_issue)
  end

  test "should destroy fixed_issue" do
    assert_difference("FixedIssue.count", -1) do
      delete fixed_issue_url(@fixed_issue)
    end

    assert_redirected_to fixed_issues_url
  end
end
