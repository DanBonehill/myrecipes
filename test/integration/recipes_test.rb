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
    assert_select "a[href=?]", edit_recipe_path(@recipe), text: "Edit Recipe"
    assert_select "a[href=?]", recipe_path(@recipe), text: "Delete Recipe"
    assert_select "a[href=?]", recipes_path, text: "Return to all recipes"
  end
  
  test "create new valid recipes" do
    get new_recipe_path
    assert_template "recipes/new"
    name_of_recipe = "chicken salad"
    description_of_recipe = "Chicken strips with lots of salad"
    assert_difference "Recipe.count", 1 do
      post recipes_path, params: { recipe: { name: name_of_recipe, description: description_of_recipe } }
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end
  
  test "reject invalid recipe submissions" do
    get new_recipe_path
    assert_template "recipes/new"
    assert_no_difference "Recipe.count" do
      post recipes_path, params: { recipe: {name: " ", description: " " } }
    end
    assert_template "recipes/new"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
end
