require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    # One way to create a Recipe
    @chef = Chef.create(chefname: "Dan", email: "dan@example.com",
                        password: "password", password_confirmation: "password")
    @chef2 = Chef.create(chefname: "John", email: "john@example.com",
                        password: "password", password_confirmation: "password")
    @admin_user = Chef.create(chefname: "Dan", email: "admin@example.com",
                        password: "password", password_confirmation: "password", admin: true)
  end
  
  test "reject an invalid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: { chefname: " ", email: "mashrur@example.com"} }
    assert_template "chefs/edit"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
  
  test "accept a valid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: { chefname: "mashrur", email: "mashrur@example.com"} }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "mashrur", @chef.chefname
    assert_match "mashrur@example.com", @chef.email
  end
  
  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: { chefname: "mashrur", email: "mashrur@example.com"} }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "mashrur", @chef.chefname
    assert_match "mashrur@example.com", @chef.email
  end
  
  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@chef2, "password")
    patch chef_path(@chef), params: { chef: { chefname: "mashrur", email: "mashrur@example.com"} }
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "Dan", @chef.chefname
    assert_match "dan@example.com", @chef.email
  end
end
