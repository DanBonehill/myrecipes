require 'test_helper'

class ChefsIndexTestTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create(chefname: "Dan", email: "dan@example.com",
                        password: "password", password_confirmation: "password", admin: true)
    @chef2 = Chef.create(chefname: "Steve", email: "steve@example.com",
                        password: "password", password_confirmation: "password")
  end
  
  test "should get chefs index" do
    get chefs_url
    assert_response :success
  end
  
  test "should get chefs listing" do
    get chefs_path
    assert_template "chefs/index"
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname
  end
  
  test "should delete chef" do
    sign_in_as(@chef, "password")
    get chefs_path
    assert_template "chefs/index"
    assert_difference "Chef.count", -1 do
      delete chef_path(@chef2)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end
end