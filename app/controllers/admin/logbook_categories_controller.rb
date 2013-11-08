class Admin::LogbookCategoriesController < ApplicationController
 before_filter :authenticate_admin!, :except => []
  layout 'admin'

  def index
  	@logbook_categories = LogbookCategory.all
  end

  def new
  	@logbook_category = LogbookCategory.new
  end

  def create
    @logbook_category = LogbookCategory.new(params[:logbook_category])
    if @logbook_category.save
	 	flash[:notice] = "logbook_category created successfully"
        redirect_to admin_logbook_categories_path
    else
        render :new
    end
  end

  def edit
      @logbook_category = LogbookCategory.find(params[:id])
    end

    def update
      @logbook_category = LogbookCategory.find(params[:id])
      if @logbook_category.update_attributes(params[:logbook_category])
        flash[:notice] = "logbook_category saved successfully"
        redirect_to admin_logbook_categories_path
      else
        render :new
      end
    end
    

    def destroy
      @logbook_category = LogbookCategory.find(params[:id])
     
      if @logbook_category.destroy
        flash[:notice] = "logbook_category deleted successfully"
        redirect_to admin_logbook_categories_path
      end
      
    end
end
