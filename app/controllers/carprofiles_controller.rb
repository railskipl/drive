class CarprofilesController < ApplicationController
  before_filter :authenticate_user!, :except => []
  def index
  	@carprofiles = current_user.carprofiles.all
  end

  def new
  	@carprofile = Carprofile.new
    
    1.times do
    carprofile_photo = @carprofile.carprofile_photos.build
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @carprofile }
    end
  end

  def create
  	@carprofile = Carprofile.new(params[:carprofile])
  	if @carprofile.save
	 	flash[:notice] = "car profile created successfully"
        redirect_to carprofiles_path
    else
        render :new
    end
  end

  def like_car

   @car_profile =Carprofile.find(params[:id])
    current_user.like!(@car_profile)
  
    current_user.spendcredits(current_user)
    
    if current_user.credit >= 0
        current_user.save
        @notification = Notification.new(:user_id => current_user.id, :notification_type => "like_comment", :notifiable_id  => @car_profile.id)
        @notification.save
    end
    
     respond_to do |format|
     format.js {}
    end
  end

  def like_count
    @car_profile= Carprofile.find(params[:id])
    @likes= Like.find_all_by_likeable_id(@car_profile.id)
  end


  def edit
  	@carprofile = Carprofile.find(params[:id])
  end

  def show
  	@carprofile = Carprofile.find(params[:id])
    @likes= Like.find_by_liker_id_and_likeable_id(current_user.id,@carprofile.id)
  end
end