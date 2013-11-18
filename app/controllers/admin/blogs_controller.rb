class Admin::BlogsController < ApplicationController
  before_filter :authenticate_admin!, :except => []
  layout 'admin'

  def index
  	@blogs = Blog.all
  end

  def new
  	@blog = Blog.new
  end

  def create
    @blog = Blog.new(params[:blog])
    if @blog.save
	 	flash[:notice] = "Blog Created Successfully"
        redirect_to admin_blogs_path
    else
        render :new
    end
  end

  def edit
      @blog = Blog.find(params[:id])
    end

    def update
      @blog = Blog.find(params[:id])
      if @blog.update_attributes(params[:blog])
        flash[:notice] = "Blog Saved Successfully"
        redirect_to admin_blogs_path
      else
        render :new
      end
    end
    

    def destroy
      @blog = Blog.find(params[:id])
     
      if @blog.destroy
        flash[:notice] = "Blog Deleted Successfully"
        redirect_to admin_blogs_path
      end
      
    end
end
