class ApplicationController < ActionController::Base
  include SimpleCaptcha::ControllerHelpers
  include ApplicationHelper
  protect_from_forgery

  before_filter :meta_defaults, :cars


  private
  def cars
    @car_makes = CarMake.order("name asc").limit(32)
    @carmakes = CarMake.all
  end


  def meta_defaults
    seo = Seo.first
    if seo.present?
      @meta_title = seo.meta_title
      @meta_keyword = seo.meta_keyword
      @meta_description = seo.meta_description
    else
      @meta_title = "Welcome to driveblogs.com"
      @meta_keyword = "The driveblogs web application is a comprehensive online cars platform geared towards the cars lovers."
      @meta_description = "The driveblogs web application is a comprehensive online cars platform geared towards the cars lovers."
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else 
      super
    end
  end
end
