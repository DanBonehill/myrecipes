require 'test_helper'

class IssueTest < ActiveSupport::TestCase
  
  def setup
    @issue = Issue.create(title: "I found a bug", body: "This thing is broken", submitted_by: "Dan")
  end
  
  test "should be valid" do
    assert @issue.valid?
  end
  
  test "title should be present" do
    @issue.title = " "
    assert_not @issue.valid?
  end
  
  test "body should be present" do
    @issue.body = " "
    assert_not @issue.valid?
  end
  
  test "Submitted by should be present" do
    @issue.submitted_by = " "
    assert_not @issue.valid?
  end
  
  test "title shouldn't be less than 3 characters" do
    @issue.title = "a" * 2
    assert_not @issue.valid?
  end
  
  test "title shouldn't be more than 50 characters" do
    @issue.title = "a" * 52
    assert_not @issue.valid?
  end
  
  test "body shouldn't be less than 5 characters" do
    @issue.body = "a" * 2
    assert_not @issue.valid?
  end
  
  test "body shouldn't be more than 500 characters" do
    @issue.body = "a" * 502
    assert_not @issue.valid?
  end
  
  test "submitted_by shouldn't be less than 3 characters" do
    @issue.submitted_by = "a" * 2
    assert_not @issue.valid?
  end
  
  test "submitted_by shouldn't be more than 30 characters" do
    @issue.submitted_by = "a" * 31
    assert_not @issue.valid?
  end
  
end