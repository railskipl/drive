class Admin::EgiftCategoriesController < ApplicationController
	before_filter :authenticate_admin!, :except => []
  layout 'admin'

  def index
  	@egift_categories = EgiftCategory.all
  end

  def new
  	@egift_category = EgiftCategory.new
  end

  def create
    @egift_category = EgiftCategory.new(params[:egift_category])
    if @egift_category.save
	 	flash[:notice] = "Egift Category Created Successfully"
        redirect_to admin_egift_categories_path
    else
        render :new
    end
  end

  def edit
      @egift_category = EgiftCategory.find(params[:id])
    end

    def update
      @egift_category = EgiftCategory.find(params[:id])
      if @egift_category.update_attributes(params[:egift_category])
        flash[:notice] = "Egift Category Saved Successfully"
        redirect_to admin_egift_categories_path
      else
        render :new
      end
    end
    

    def destroy
      @egift_category = EgiftCategory.find(params[:id])
     
      if @egift_category.destroy
        flash[:notice] = "Egift Category Deleted Successfully"
        redirect_to admin_egift_categories_path
      end
      
    end
end
