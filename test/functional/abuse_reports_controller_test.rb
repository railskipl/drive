require 'test_helper'

class AbuseReportsControllerTest < ActionController::TestCase
  setup do
    @abuse_report = abuse_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:abuse_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create abuse_report" do
    assert_difference('AbuseReport.count') do
      post :create, abuse_report: { abuse_category_id: @abuse_report.abuse_category_id, abuse_type: @abuse_report.abuse_type, abuser_user_id: @abuse_report.abuser_user_id, carprofile_id: @abuse_report.carprofile_id, comment_id: @abuse_report.comment_id, comments: @abuse_report.comments, logbook_id: @abuse_report.logbook_id, user_blog_id: @abuse_report.user_blog_id, user_id: @abuse_report.user_id }
    end

    assert_redirected_to abuse_report_path(assigns(:abuse_report))
  end

  test "should show abuse_report" do
    get :show, id: @abuse_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @abuse_report
    assert_response :success
  end

  test "should update abuse_report" do
    put :update, id: @abuse_report, abuse_report: { abuse_category_id: @abuse_report.abuse_category_id, abuse_type: @abuse_report.abuse_type, abuser_user_id: @abuse_report.abuser_user_id, carprofile_id: @abuse_report.carprofile_id, comment_id: @abuse_report.comment_id, comments: @abuse_report.comments, logbook_id: @abuse_report.logbook_id, user_blog_id: @abuse_report.user_blog_id, user_id: @abuse_report.user_id }
    assert_redirected_to abuse_report_path(assigns(:abuse_report))
  end

  test "should destroy abuse_report" do
    assert_difference('AbuseReport.count', -1) do
      delete :destroy, id: @abuse_report
    end

    assert_redirected_to abuse_reports_path
  end
end
