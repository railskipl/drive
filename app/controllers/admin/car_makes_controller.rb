class Admin::CarMakesController < ApplicationController
	 before_filter :authenticate_admin!, :except => []
  layout 'admin'

  def index
  	@car_makes = CarMake.all
  end

  def new
  	@car_make = CarMake.new
  end

  def create
    @car_make = CarMake.new(params[:car_make])
    if @car_make.save
	 	flash[:notice] = "Car Make Created Successfully"
        redirect_to admin_car_makes_path
    else
        render :new
    end
  end

  def edit
      #raise params.inspect
      @car_make = CarMake.find(params[:id])
    end

    def update
      @car_make = CarMake.find(params[:id])
      if @car_make.update_attributes(params[:car_make])
        flash[:notice] = "Car Make Saved Successfully"
        if params[:type] == "Update Make"
          redirect_to manage_bodyindices_path
        else
         redirect_to admin_car_makes_path
        end
      else
        render :new
      end
    end
    

    def destroy

      @car_make = CarMake.find(params[:id])
     
      if @car_make.destroy
        flash[:notice] = "Car Make Deleted Successfully"
        if params[:type] == "make"
          redirect_to manage_bodyindices_path
        else
          redirect_to admin_car_makes_path
        end
        
      end
      
    end
end
