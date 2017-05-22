require "test_helper"

class CommentTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create(chefname: "Dan", email: "dan@example.com",
                      password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Vegetable", description: "Great Vegetable Salad", chef: @chef)
    @comment = Comment.create(description: "I love this recipe", chef: @chef, recipe: @recipe)
  end

  test "should be valid" do
    assert @comment.valid?
  end
  
  test "should have description" do
    @comment.description = " "
    assert_not @comment.valid?
  end
  
  test "should have at least 4 characters" do
    @comment.description = "a" * 3
    assert_not @comment.valid?
  end
  
  test "should have no more than 140 characters" do
    @comment.description = "a" * 141
    assert_not @comment.valid?
  end
  
  test "should belong to chef" do
    assert @comment.chef != nil
  end
  
  test "should belong to recipe" do
    assert @comment.recipe != nil
  end

end