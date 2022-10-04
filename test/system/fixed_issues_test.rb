require "application_system_test_case"

class FixedIssuesTest < ApplicationSystemTestCase
  setup do
    @fixed_issue = fixed_issues(:one)
  end

  test "visiting the index" do
    visit fixed_issues_url
    assert_selector "h1", text: "Fixed issues"
  end

  test "should create fixed issue" do
    visit fixed_issues_url
    click_on "New fixed issue"

    click_on "Create Fixed issue"

    assert_text "Fixed issue was successfully created"
    click_on "Back"
  end

  test "should update Fixed issue" do
    visit fixed_issue_url(@fixed_issue)
    click_on "Edit this fixed issue", match: :first

    click_on "Update Fixed issue"

    assert_text "Fixed issue was successfully updated"
    click_on "Back"
  end

  test "should destroy Fixed issue" do
    visit fixed_issue_url(@fixed_issue)
    click_on "Destroy this fixed issue", match: :first

    assert_text "Fixed issue was successfully destroyed"
  end
end
