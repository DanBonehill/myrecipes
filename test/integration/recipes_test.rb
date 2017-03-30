require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    # One way to create a Recipe
    @chef = Chef.create(chefname: "Dan", email: "dan@example.com")
    @recipe = Recipe.create(name: "Chicken Salad", description: "Fresh salad with Chicken strips", chef: @chef)
    # Second way to create a Recipe
    @recipe2 = @chef.recipes.build(name: "Steak and Chips", description: "Rump steak with chips")
    @recipe2.save
  end
  
  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end
  
  test "should get recipes listing" do
    get recipes_path
    assert_template "recipes/index"
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end
end
