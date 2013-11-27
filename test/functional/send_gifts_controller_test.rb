require 'test_helper'

class SendGiftsControllerTest < ActionController::TestCase
  setup do
    @send_gift = send_gifts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:send_gifts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create send_gift" do
    assert_difference('SendGift.count') do
      post :create, send_gift: { carprofile_id: @send_gift.carprofile_id, egift_id: @send_gift.egift_id, message: @send_gift.message }
    end

    assert_redirected_to send_gift_path(assigns(:send_gift))
  end

  test "should show send_gift" do
    get :show, id: @send_gift
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @send_gift
    assert_response :success
  end

  test "should update send_gift" do
    put :update, id: @send_gift, send_gift: { carprofile_id: @send_gift.carprofile_id, egift_id: @send_gift.egift_id, message: @send_gift.message }
    assert_redirected_to send_gift_path(assigns(:send_gift))
  end

  test "should destroy send_gift" do
    assert_difference('SendGift.count', -1) do
      delete :destroy, id: @send_gift
    end

    assert_redirected_to send_gifts_path
  end
end
