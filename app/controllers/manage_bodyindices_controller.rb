class ManageBodyindicesController < ApplicationController
  before_filter :authenticate_admin!, :except => []
	layout 'admin'
  def index
  	#q = params[:q]
  	@car_makes =   CarMake.search(params[:name]).result
  	
  end

end
