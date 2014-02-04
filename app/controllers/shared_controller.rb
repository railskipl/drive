class SharedController < ApplicationController

  helper_method  :total_rating_count
  def index
    @car_makes = CarMake.order("created_at desc").limit(100)
    #@car_photo = Carprofile.order("created_at desc").limit(2)
  end

  def search
    #     if params[:id]
    @car_make = CarMake.find_by_id(params[:id])
    @carprofile = Carprofile.find_by_id(params[:id])
    #   end
    #   @carprofiles = @car_make.carprofiles.paginate(page: params[:page], per_page: 40)
    # end
    @car_models = CarModel.find_all_by_car_make_id(@car_make.id)
    @carprofiles = @car_make.carprofiles.paginate(page: params[:page], per_page: 40)
    @logbooks = Logbook.find_all_by_car_model_id(@car_modals)
  end

  def car_body_index
    if params[:body_index_id].present?
      @car_make = CarMake.find(params[:car_make])
      @car_model = CarModel.find_by_id(params[:car_model])
      @body_index = BodyIndex.find(params[:body_index_id])
      @carprofiles = @body_index.carprofiles
    else
      @car_make = CarMake.find(params[:car_make])
      @car_model = CarModel.find_by_id(params[:id])
      @body_indices = @car_model.body_indices
      @carprofiles = @car_model.carprofiles.paginate(page: params[:page], per_page: 40)
    end
  end

  protected

  def total_rating_count(carprofile_id)
    carprofile = Carprofile.find(carprofile_id)
    count = 0
    count += carprofile.send_gifts.count rescue 0
    count += Like.find_all_by_likeable_type_and_likeable_id("Carprofile",carprofile.id).map(&:count).inject(:+).nil? ? 0 : Like.find_all_by_likeable_type_and_likeable_id("Carprofile",carprofile.id).map(&:count).inject(:+) rescue 0
    count += carprofile.comments_count rescue 0
    count += carprofile.logbooks.count rescue 0
    count += carprofile.favourites.count rescue 0
    count += Subscriber.find_all_by_subscribable_id(carprofile.id).count rescue 0
    count += Carprofile.find(carprofile.id).spotlighted ? 1 : 0  rescue 0
  end

end

#
#@body_indices = BodyIndex.find_all_by_car_model_id(@car_model.id).paginate(page: params[:page], per_page: 40)
