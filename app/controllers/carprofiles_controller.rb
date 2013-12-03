class CarprofilesController < ApplicationController
  
  before_filter :authenticate_user!, :except => []
  before_filter :correct_user, :only => [:edit]
   START_DATEEE = SendGift.first.created_at.to_date
  def index
  	@carprofiles = current_user.carprofiles.all
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    #raise @carprofiles.inspect
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
    #raise @carprofile.inspect
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
      @likes= @car_profile.likes(@car_profile.id)
      
      @count ||= []
      @likes.each do |like|
         @count << like.count
      end
       @counts = @car_profile.sum_counts(@count)

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
  
  def update
    @carprofile = Carprofile.find(params[:id])
   

      respond_to do |format|
      if @carprofile.update_attributes(params[:carprofile])
        format.html { redirect_to @carprofile, notice: 'Car Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @carprofile.errors, status: :unprocessable_entity }
      end
    end


  end

  def entry_index_to_display
    @egift = @carprofile.send_gifts
    today = Date.today
    interval = (today - START_DATEEE).to_i
    index = (interval/7.0).floor
    index % @egift.count
  end
 
  def show
      @carprofile = Carprofile.find(params[:id])
      @egift = @carprofile.send_gifts
      offset = entry_index_to_display rescue ""
      @record = @egift.limit(1).offset(offset).first
      @public = @egift.public_gift
      @personal = @egift.personal
      @anon = @egift.anonymous
      
      @likes= @carprofile.likes(@carprofile.id)
      @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
     

      @count ||= []
      @likes.each do |like|
         @count << like.count
      end
        @counts = @carprofile.sum_counts(@count)
     end


  def update_model
    #raise params[:update_model].inspect
     @car_model = CarModel.find_all_by_car_make_id(params[:update_model]) 
  end

  def update_body
    @body_index = BodyIndex.find_all_by_car_model_id(params[:update_body])
  end

def subscribe_car
  @carprofile = Carprofile.find(params[:id])
  if Subscriber.subscribes?(current_user,@carprofile)
    Subscriber.unsubscribe!(current_user,@carprofile)
  else
    Subscriber.subscribe!(current_user,@carprofile)
  end
   respond_to do |format|
     format.js {}
    end
 
end

def subscar_count
 @carprofile = Carprofile.find(params[:id])
 @subscribers =  Subscriber.subscribers(@carprofile,User)
end

def spotlight
@car_profile = Carprofile.find_by_id(params[:id])
Carprofile.spotlight(@car_profile)
end


private
 
 def correct_user
   @carprofile = Carprofile.find(params[:id])
   @user = current_user
   if @carprofile.user == current_user 
   else 
    redirect_to carprofile_path(@carprofile) ,:notice => "Access Denied"
   end
 end

end