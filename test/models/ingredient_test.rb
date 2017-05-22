require "test_helper"

class IngredientTest < ActiveSupport::TestCase
  
  def setup
    @ingredient = Ingredient.new(name: "chicken")
  end
  
  test "should be valid" do
    assert @ingredient.valid?
  end
  
  test "should have name" do
    @ingredient.name = " "
    assert_not @ingredient.valid?
  end
  
  test "should be lowercase" do
    @ingredient.name = "Chicken"
    assert @ingredient.name = @ingredient.name.downcase
  end
  
  test "should be unique" do
    duplicate_ingredient = @ingredient.dup
    @ingredient.save
    assert_not duplicate_ingredient.valid?
  end
  
  test "should be at least 3 characters" do
    @ingredient.name = "a" * 2
    assert_not @ingredient.valid?
  end
  
  test "should be no more than 25 characters" do
    @ingredient.name = "a" * 26
    assert_not @ingredient.valid?
  end
  
end