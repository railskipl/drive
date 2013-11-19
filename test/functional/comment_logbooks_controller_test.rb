require 'test_helper'

class CommentLogbooksControllerTest < ActionController::TestCase
  setup do
    @comment_logbook = comment_logbooks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comment_logbooks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comment_logbook" do
    assert_difference('CommentLogbook.count') do
      post :create, comment_logbook: { body: @comment_logbook.body, logbook_id: @comment_logbook.logbook_id, user_id: @comment_logbook.user_id }
    end

    assert_redirected_to comment_logbook_path(assigns(:comment_logbook))
  end

  test "should show comment_logbook" do
    get :show, id: @comment_logbook
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comment_logbook
    assert_response :success
  end

  test "should update comment_logbook" do
    put :update, id: @comment_logbook, comment_logbook: { body: @comment_logbook.body, logbook_id: @comment_logbook.logbook_id, user_id: @comment_logbook.user_id }
    assert_redirected_to comment_logbook_path(assigns(:comment_logbook))
  end

  test "should destroy comment_logbook" do
    assert_difference('CommentLogbook.count', -1) do
      delete :destroy, id: @comment_logbook
    end

    assert_redirected_to comment_logbooks_path
  end
end
