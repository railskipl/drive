class Admin::PagesController < ApplicationController
  def index
    	@pages = Page.all
    end

    def new

    	@page = Page.new
    end

    def create

    	@page = Page.new(params[:page])

    	if @page.save 
    		redirect_to admin_pages_path
    	else
    		render 'new'
    	end
    end
	
    def edit
        @page = Page.find(params[:id])
    end

    def update
        @page = Page.find(params[:id])
        if @page.update_attributes(params[:page])
            flash[:notice] = "page saved successfully"
            redirect_to admin_pages_path
        else
            render :new
        end
    end

    def destroy
        @page = Page.find(params[:id])

        if @page.destroy
            redirect_to admin_pages_path
            flash[:notice] = "Destroyed successfully"
        end
    end
end
