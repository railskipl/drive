class SharedController < ApplicationController
  def index
    @car_makes = CarMake.order("created_at desc").limit(100)
    #@car_photo = Carprofile.order("created_at desc").limit(2)
  end

  def search
  #     if params[:id]
    @car_make = CarMake.find_by_id(params[:id])
  #   end
  #   @carprofiles = @car_make.carprofiles.paginate(page: params[:page], per_page: 40)
  # end
    @car_models = CarModel.find_all_by_car_make_id(@car_make.id).paginate(page: params[:page], per_page: 40)
  end


 def car_body_index
   @car_model = CarModel.find_by_id(params[:id])
   @carprofiles = @car_model.carprofiles.paginate(page: params[:page], per_page: 40)

 end
 end



  #@body_indices = BodyIndex.find_all_by_car_model_id(@car_model.id).paginate(page: params[:page], per_page: 40)
