class ManageBodyindicesController < ApplicationController
  before_filter :authenticate_admin!, :except => []
	layout 'admin'
  def index
  	q = params[:q]
  	@car_makes =   CarMake.search(name_cont: q).result
  	
  end

end
