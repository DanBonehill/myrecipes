require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create(chefname: "Dan", email: "dan@example.com")
    @recipe = Recipe.create(name: "Chicken salad", description: "Fresh salad with Chicken strips", chef: @chef)
  end
  
  test "reject invalid recipe update" do
    get edit_recipe_path(@recipe)
    assert_template "recipes/edit"
    patch recipe_path(@recipe), params: { recipe: { name: " ", description: "some description" } }
    assert_template "recipes/edit"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
  
  test "successfully edit a recipe" do
    get edit_recipe_path(@recipe)
    assert_template "recipes/edit"
    updated_name = "Updated recipe name"
    updated_desciprtion = "updated recipe description"
    patch recipe_path(@recipe), params: { recipe: { name: updated_name, description: updated_desciprtion } }
    # Could use follow_redirect!
    assert_redirected_to @recipe
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_desciprtion, @recipe.description
  end
end
