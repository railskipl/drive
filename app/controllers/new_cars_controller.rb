class NewCarsController < ApplicationController
  def index
  	    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)

  	@car_photo = Carprofile.order("created_at desc").limit(50)
  end
end
