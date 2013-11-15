class ApplicationController < ActionController::Base
  include SimpleCaptcha::ControllerHelpers
  protect_from_forgery

  before_filter :meta_defaults


  private


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
end
