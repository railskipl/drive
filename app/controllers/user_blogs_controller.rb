class UserBlogsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  def index
  	@user_blogs = current_user.user_blogs.all
  end

  def new
  	@user_blog = UserBlog.new
  end

  def edit
  	@user_blog = UserBlog.find(params[:id])
  	
  end

  def create
  	 @user_blog = UserBlog.new(params[:user_blog])
	  	if @user_blog.save
	  	 	flash[:notice] = "Blog created successfully."
	  	 	redirect_to user_blogs_path
	  	else
	  	 	render :new
	  	end
  end

  def update
  	@user_blog = UserBlog.find(params[:id])
  	if @user_blog.update_attributes(params[:user_blog])
  		flash[:notice] = "Blog updated successfully."
  		redirect_to user_blogs_path
  	else
  		render :new
  	end
  	
  end

  def show
  	@user_blog = UserBlog.find(params[:id])
    @blog_comment = @user_blog.blog_comments.build
  end

  def destroy
  	@user_blog = UserBlog.find(params[:id])
  	if @user_blog.destroy
  		flash[:notice] = "Deleted successfully."
  		redirect_to user_blogs_path
  	end
  end
end
