class Admin::CarModelsController < ApplicationController
 before_filter :authenticate_admin!, :except => []
  layout 'admin'

  def index
  	@car_models = CarModel.all
  end

  def new
  	@car_model = CarModel.new
  end

  def create
    @car_model = CarModel.new(params[:car_model])
    if @car_model.save
	 	flash[:notice] = "car_model created successfully"
        redirect_to admin_car_models_path
    else
        render :new
    end
  end

  def edit
      @car_model = CarModel.find(params[:id])
    end

    def update
      @car_model = CarModel.find(params[:id])
      if @car_model.update_attributes(params[:car_model])
        flash[:notice] = "car_model saved successfully"
        redirect_to admin_car_models_path
      else
        render :new
      end
    end
    

    def destroy
      @car_model = CarModel.find(params[:id])
     
      if @car_model.destroy
        flash[:notice] = "car_model deleted successfully"
        redirect_to admin_car_models_path
      end
      
    end
end
