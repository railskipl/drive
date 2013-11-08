class Admin::EgiftsController < ApplicationController
 before_filter :authenticate_admin!, :except => []
  layout 'admin'

  def index
  	@egifts = Egift.all
  end

  def new
  	@egift = Egift.new
  end

  def create
    @egift = Egift.new(params[:egift])
    if @egift.save
	 	flash[:notice] = "egift created successfully"
        redirect_to admin_egifts_path
    else
        render :new
    end
  end

  def edit
      @egift = Egift.find(params[:id])
    end

    def update
      @egift = Egift.find(params[:id])
      if @egift.update_attributes(params[:egift])
        flash[:notice] = "egift saved successfully"
        redirect_to admin_egifts_path
      else
        render :new
      end
    end
    

    def destroy
      @egift = Egift.find(params[:id])
     
      if @egift.destroy
        flash[:notice] = "egift deleted successfully"
        redirect_to admin_egifts_path
      end
      
    end
end
