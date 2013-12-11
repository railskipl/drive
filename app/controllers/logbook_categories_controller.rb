class LogbookCategoriesController < ApplicationController

	def search

    @logbook_categories =  LogbookCategory.all
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    @carprofile = current_user.carprofiles
    if  params[:name]
       @logbook_category = LogbookCategory.find_by_name(params[:name])
    end
    @logbooks = @logbook_category.logbooks.paginate(page: params[:page], per_page: 5) 
    @logbooks = @logbooks.order("created_at desc")
  end
end
