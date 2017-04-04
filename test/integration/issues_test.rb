require 'test_helper'

class IssuesTest < ActionDispatch::IntegrationTest
  
  def setup
    @issue = Issue.create(title: "I found a bug", body: "This thing is broken", submitted_by: "Dan")
  end
  
end