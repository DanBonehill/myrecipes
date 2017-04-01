require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    # One way to create a Recipe
    @chef = Chef.create(chefname: "Dan", email: "dan@example.com")
    @recipe = Recipe.create(name: "Chicken salad", description: "Fresh salad with Chicken strips", chef: @chef)
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
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end
  
  test "shoulld get recipes show" do
    get recipe_path(@recipe)
    assert_template "recipes/show"
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
  end
end
