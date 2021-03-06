class LogbooksController < ApplicationController
  require 'will_paginate/array'
  before_filter :authenticate_user!
  respond_to :html, :js

   def index
    @logbooks = current_user.logbooks.find(:all , :order => "created_at DESC").paginate(page: params[:page], per_page: 5) 
    
    #@logbooks = @logbooks.paginate(page: params[:page], per_page: 5) 
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    @logbook_categories =  LogbookCategory.all
    @carprofile = Carprofile.all
    @friends = current_user.friends
  end

  def all_logbook
    #@logbook = Logbook.find(:all , :order => "created_at DESC") 
    @logbook = Logbook.where(:status =>  true).order("created_at DESC").paginate(page: params[:page], per_page: 5)
    #@logbook = @logbook.paginate(page: params[:page], per_page: 5)
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    @carprofile = current_user.carprofiles
    @logbook_categories =  LogbookCategory.all
  end

  def myfriend
    @friends = current_user.friends
    @logbook = Logbook.where(:status =>  true).order("created_at DESC")
    @logbooks = @logbook.find_all_by_user_id(@friends)
    @logbooks = @logbooks.paginate(page: params[:page], per_page: 5)
    #raise @logbooks.inspect
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    @carprofile = current_user.carprofiles
    @logbook_categories =  LogbookCategory.all

  end

  def previews
    #raise "hi"
    @description = params[:prevdata].force_encoding("ISO-8859-1").encode("UTF-8")
  end

  def new
  	@logbook = Logbook.new
    unless params[:type] == "carprofile"
     @carprofile = current_user.carprofiles
    else 
     @carprofile = Carprofile.find_all_by_id(params[:id])
    end
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  end

  def create
    @logbook = Logbook.create(params[:logbook])
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    @logbook.status = "true" if params[:publish] == "Publish"
    @carprofile = current_user.carprofiles


    if @logbook.logbook_discription == "<br>"
      flash[:notice] = "please fill all fields"
      redirect_to new_logbook_path
    else 
      if @logbook.save
        flash[:notice] = "Logbook created successfully"
        redirect_to logbooks_path
      else
        render :new
      end
    end
  end

  def edit
    @logbook = Logbook.find(params[:id])
    if @logbook.user == current_user
    @carprofile = current_user.carprofiles
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    else
       @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
       redirect_to root_path ,:notice => "Access Denied"
    end
  end

  def like_logbook

   @logbook = Logbook.find(params[:id])

    current_user.like!(@logbook)
   
    @likes= Like.find_all_by_likeable_id(@logbook.id)
    @likes = @logbook.likes(@logbook.id)
   
      @count ||= []
      @likes.each do |like|
         @count << like.count 
      end
      
      @count = @logbook.sum_counts(@count)


      current_user.spendcredits(current_user)
    #raise @logbook.user_id.inspect
    if current_user.credit >= 0
        current_user.save
        @notification = Notification.create(:user_id => current_user.id, :notification_type => "like_logbooks", :notifiable_id  => @logbook.user_id)
        @notification.save
    end
    
     respond_to do |format|
     format.js {}
    end
  end

  def like_count
    @logbook = Logbook.find(params[:id])
    @likes= Like.find_all_by_liker_and_likeable_id(@logbook.id)
  end
  def update
  	@logbook = Logbook.find(params[:id])
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    @logbook.status = "true" if params[:publish] == "Publish"
    @logbook.status = "false" if params[:draft] == "Save as Draft"
    @carprofile = current_user.carprofiles
  	if @logbook.update_attributes(params[:logbook])
  		flash[:notice] = "Logbook updated successfully"
  		redirect_to logbooks_path
  	else
  		render :new
  	end
  end

  def show
  
    @logbook = Logbook.find(params[:id])
    @abuse_report = AbuseReport.new
    @favourite = current_user.favourites.where(:favourite_type => "favourite_logbook")
    @favourites = @favourite.find_by_logbook_id(@logbook)
    #raise @favourites.inspect
    @comment_logbook = @logbook.comment_logbooks.build
   
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    @likes = @logbook.likes(@logbook.id)
      
      @count ||= []
      @likes.each do |like|
         @count << like.count
      end
    @counts = @logbook.sum_counts(@count)

  end

  def destroy
  	@logbook = Logbook.find(params[:id])
  	if @logbook.destroy

    	flash[:notice] = "Deleted successfully"
    	redirect_to logbooks_path
    end
  end

  def updatemodel
    #raise params[:update_model].inspect
     @car_model = CarModel.find_all_by_car_make_id(params[:updatemodel]) 
  end

  def updatebody
    @body_index = BodyIndex.find_all_by_car_model_id(params[:updatebody])
  end

  def logbooksearch
        @spotlighted_cars = Carprofile.where("spotlighted = ?",true)

    q = params[:q]
    @logbooks =   Logbook.search(title_cont: q).result
    @logbook_categories =  LogbookCategory.all
    #@logbook_categories =  LogbookCategory.search(name_cont: q).result
    @logbooks = @logbooks.where(:status => true).order("created_at DESC").paginate(page: params[:page], per_page: 5)
  end
end
