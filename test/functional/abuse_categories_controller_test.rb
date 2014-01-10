require 'test_helper'

class AbuseCategoriesControllerTest < ActionController::TestCase
  setup do
    @abuse_category = abuse_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:abuse_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create abuse_category" do
    assert_difference('AbuseCategory.count') do
      post :create, abuse_category: { name: @abuse_category.name }
    end

    assert_redirected_to abuse_category_path(assigns(:abuse_category))
  end

  test "should show abuse_category" do
    get :show, id: @abuse_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @abuse_category
    assert_response :success
  end

  test "should update abuse_category" do
    put :update, id: @abuse_category, abuse_category: { name: @abuse_category.name }
    assert_redirected_to abuse_category_path(assigns(:abuse_category))
  end

  test "should destroy abuse_category" do
    assert_difference('AbuseCategory.count', -1) do
      delete :destroy, id: @abuse_category
    end

    assert_redirected_to abuse_categories_path
  end
end
