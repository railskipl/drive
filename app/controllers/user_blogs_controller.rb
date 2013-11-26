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

  def like_blog

   @user_blog = UserBlog.find(params[:id])
    current_user.like!(@user_blog)
      @likes = @user_blog.likes(@user_blog.id)
      
      @count ||= []
      @likes.each do |like|
         @count << like.count
      end
       @count = @user_blog.sum_counts(@count)
    current_user.spendcredits(current_user)
    
    if current_user.credit >= 0
        current_user.save
        @notification = Notification.new(:user_id => current_user.id, :notification_type => "like_blog", :notifiable_id  => @user_blog.id)
        @notification.save
    end
    
     respond_to do |format|
     format.js {}
    end
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
    @user = User.find(params[:id])
  	@user_blog = UserBlog.find(params[:id])
    @blog_comment = @user_blog.blog_comments.build
    @likes = @user_blog.likes(@user_blog.id)
      
      @count ||= []
      @likes.each do |like|
         @count << like.count
      end
  end

  def destroy
  	@user_blog = UserBlog.find(params[:id])
  	if @user_blog.destroy
  		flash[:notice] = "Deleted successfully."
  		redirect_to user_blogs_path
  	end
  end
end
