require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  test "should get root" do
    get :home
    assert_response :success
  end

  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
    end
    
  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end
end

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path  
  end
end
