require 'test_helper'

class ContactadminsControllerTest < ActionController::TestCase
  setup do
    @contactadmin = contactadmins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contactadmins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contactadmin" do
    assert_difference('Contactadmin.count') do
      post :create, contactadmin: { message: @contactadmin.message, subject: @contactadmin.subject }
    end

    assert_redirected_to contactadmin_path(assigns(:contactadmin))
  end

  test "should show contactadmin" do
    get :show, id: @contactadmin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contactadmin
    assert_response :success
  end

  test "should update contactadmin" do
    put :update, id: @contactadmin, contactadmin: { message: @contactadmin.message, subject: @contactadmin.subject }
    assert_redirected_to contactadmin_path(assigns(:contactadmin))
  end

  test "should destroy contactadmin" do
    assert_difference('Contactadmin.count', -1) do
      delete :destroy, id: @contactadmin
    end

    assert_redirected_to contactadmins_path
  end
end
