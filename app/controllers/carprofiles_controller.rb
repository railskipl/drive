class CarprofilesController < ApplicationController
  before_filter :authenticate_user!, :except => []
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
 
  def show
      @carprofile = Carprofile.find(params[:id])
      @egift = @carprofile.send_gifts
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
  @car_subscribe = Carprofile.find(params[:id])
  # binding.pry 
   Subscriber.subscribe!(current_user,@car_subscribe)
    # @subscribers= @car_subscribe.subscribes(@car_subscribe.id)
    respond_to do |format|
     format.js {}
    end
 end

def subscribe_count
@car_subscribe= Carprofile.find(params[:id])

#binding.pry
 @subscribers =  Subscriber.find_all_by_subscribable_id(@car_subscribe.id)
end

def spotlight
@car_profile = Carprofile.find_by_id(params[:id])
# binding.pry
@status = Carprofile.spotlight(@car_profile)
end

  
end