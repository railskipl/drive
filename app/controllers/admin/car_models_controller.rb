class Admin::CarModelsController < ApplicationController
 before_filter :authenticate_admin!, :except => []
  layout 'admin'

  def index
  	@car_models = CarModel.all(:order => "name")
  end

  def new
  	@car_model = CarModel.new
    #@car_makes = CarMake.all
  end

  def create
    @car_model = CarModel.new(params[:car_model])
    if @car_model.save
	 	flash[:notice] = "Car Model Created Successfully"
        redirect_to admin_car_models_path
    else
        render :new
    end
  end

    def edit
      @car_model = CarModel.find(params[:id])
      @car_makes = []
      session[:car_make_id] = @car_model.car_make_id
        if session[:car_make_id] 
         @car_makes = CarMake.find_all_by_id(session[:car_make_id])
        end
    end

    def update
      #raise params.inspect
      @car_model = CarModel.find(params[:id])
      session.delete(:car_make_id)
      if @car_model.update_attributes(params[:car_model])
         
        flash[:notice] = "Car Model Saved Successfully"
        if params[:type] == "Update Model"
          redirect_to manage_bodyindices_path
        else
          redirect_to admin_car_models_path
        end
      else
        render :new
      end
    end
    

    def destroy
      @car_model = CarModel.find(params[:id])
     
      if @car_model.destroy
        flash[:notice] = "Car Model Deleted Successfully"
        if params[:type] == "model"
           redirect_to manage_bodyindices_path
        else
          redirect_to admin_car_models_path
        end
      end
      
    end
end
