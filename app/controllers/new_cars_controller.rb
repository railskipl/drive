class NewCarsController < ApplicationController
	before_filter :authenticate_user!
  def index
  	    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)

  	@car_photo = Carprofile.order("created_at desc").limit(100)
  end
end
