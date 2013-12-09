class LogbooksController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  def index
  	@logbooks = current_user.logbooks.all
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    @logbook_categories =  LogbookCategory.all
    @carprofile = current_user.carprofiles
    #raise @logbooks.inspect
  end

  def new
  	@logbook = Logbook.new
    @carprofile = current_user.carprofiles
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  end

  def create
    @logbook = Logbook.create(params[:logbook])
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
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
    @carprofile = current_user.carprofiles
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
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
    
    if current_user.credit >= 0
        current_user.save
        @notification = Notification.new(:user_id => current_user.id, :notification_type => "like_logbooks", :notifiable_id  => @logbook.id)
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
  	if @logbook.update_attributes(params[:logbook])
  		flash[:notice] = "Logbook updated successfully"
  		redirect_to logbooks_path
  	else
  		render :new
  	end
  end

  def show
  
    @logbook = Logbook.find(params[:id])
    @comment_logbook = @logbook.comment_logbooks.build
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    @likes = @logbook.likes(@logbook.id)
      
      @count ||= []
      @likes.each do |like|
         @count << like.count
      end

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
end
