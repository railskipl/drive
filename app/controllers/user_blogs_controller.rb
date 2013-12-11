class UserBlogsController < ApplicationController
  require 'will_paginate/array'
  before_filter :authenticate_user!, :except => [:show]
  def index
    @user_blogs = current_user.user_blogs.find(:all , :order => "created_at DESC").paginate(page: params[:page], per_page: 5) 
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    @blog_comments = BlogComment.order("created_at desc").limit(100)
    @blogs  = Blog.all
    #raise @blog_comments.inspect
  end


  def all_blogs
    @user_blogs = UserBlog.find(:all , :order => "created_at DESC").paginate(page: params[:page], per_page: 5)
    @blogs  = Blog.all
    @blog_comments = BlogComment.order("created_at desc").limit(100)
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  end

  def new
  	@user_blog = UserBlog.new
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  end

  def edit
  	@user_blog = UserBlog.find(params[:id])
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  	
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
     @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    if @user_blog.body == "<br>"
      flash[:notice] = "please fill all fields"
      redirect_to new_user_blog_path
    else
      if @user_blog.save
        flash[:notice] = "Blog created successfully."
        redirect_to user_blogs_path
      else
        render :new
      end
    end
  end

  def update
     @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
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
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
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
