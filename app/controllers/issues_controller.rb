class IssuesController < ApplicationController
  
  def new
    @issue = Issue.new
  end
end