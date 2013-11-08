class Admin::DashboardController < ApplicationController
  before_filter :authenticate_admin!, :except => []
  layout 'admin'
  def index
  end
end
