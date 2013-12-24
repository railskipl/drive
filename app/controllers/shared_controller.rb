class SharedController < ApplicationController
  def index
  	@car_makes = CarMake.order("created_at desc").limit(100)
  	#@car_photo = Carprofile.order("created_at desc").limit(2)
  end

  def search
  	if params[:id]
    @car_make = CarMake.find_by_id(params[:id])
    end
    @carprofiles = @car_make.carprofiles.paginate(page: params[:page], per_page: 40)
  end
end
