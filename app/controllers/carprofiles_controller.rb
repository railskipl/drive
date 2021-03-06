class CarprofilesController < ApplicationController
  impressionist :actions=>[:show] ,:unique => [:impressionable_id,:impressionable_type,:session_hash]
  before_filter :authenticate_user!, :except => []
  before_filter :correct_user, :only => [:edit]
   START_DATEEE = SendGift.first.created_at.to_date rescue ""
  def index
  	@carprofiles = current_user.carprofiles.find(:all, :order => "created_at DESC")
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    #raise @carprofiles.inspect
   
  end

  def new
  	@carprofile = Carprofile.new
    
    1.times do
    carprofile_photo = @carprofile.carprofile_photos.build
    end
    
      @car_model = []
      @body_index = []
      respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @carprofile }
    end
  end

  def create
    
  	@carprofile = Carprofile.new(params[:carprofile])
    #if @carprofile.car_make_id.nil? && @carprofile.car_model_id && @carprofile
    session[:car_make_id] = @carprofile.car_make_id
    session[:car_model_id] = @carprofile.car_model_id
    if session[:car_make_id]
      @car_model = CarModel.find_all_by_car_make_id(session[:car_make_id])
      
    end
    if session[:car_model_id]
      @body_index = BodyIndex.find_all_by_car_model_id(session[:car_model_id])
    end


    #raise @carprofile.inspect
    if @carprofile.save
      session.delete(:car_make_id)
      session.delete(:car_model_id)
      
	 	flash[:notice] = "car profile created successfully"
        redirect_to carprofiles_path
    else
        render :new
    end
  end

  def like_car

   @car_profile =Carprofile.find(params[:id])
   #raise @car_profile.user_id.inspect
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
        @notification = Notification.create(:user_id => current_user.id, :notification_type => "like_carprofile", :notifiable_id  => @car_profile.user_id)
        #@notification.save
    end
      @class = rate_count(@car_profile.id)[0]
     respond_to do |format|
     format.js {}
    end
  end

  def like_count
    @car_profile= Carprofile.find(params[:id])
    @likes = @car_profile.likes(@car_profile.id)
    @likes = @likes.delete_if {|i| i.count == 0 }
  end


  def edit
  	@carprofile = Carprofile.find(params[:id])

    @car_model = []
    @body_index = []
    session[:car_make_id] = @carprofile.car_make_id
    session[:car_model_id] = @carprofile.car_model_id

    if session[:car_make_id]
      @car_model = CarModel.find_all_by_car_make_id(session[:car_make_id])
      
    end
    if session[:car_model_id]
      @body_index = BodyIndex.find_all_by_car_model_id(session[:car_model_id])
    end
  end
  
  def update
    @carprofile = Carprofile.find(params[:id])
    @subscribers = Subscriber.find_all_by_subscribable_id(@carprofile.id)
    @subscribers.each do |sub|
     @notification = Notification.create(:user_id => current_user.id, :notification_type => "subscriber_carprofile", :notifiable_id  => sub.subscriber_id)
    end
      respond_to do |format|
      if @carprofile.update_attributes(params[:carprofile])
        session.delete(:car_make_id)
        session.delete(:car_model_id)
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
      @abuse_report = AbuseReport.new
      @subscribers = Subscriber.find_all_by_subscribable_id(@carprofile.id)
      @logbooks = @carprofile.logbooks
      @egift = @carprofile.send_gifts
      offset = entry_index_to_display rescue ""
      @record = @egift.limit(1).offset(offset).first
      @public = @egift.public_gift
      @personal = @egift.personal
      @anon = @egift.anonymous
      @favourites  = @carprofile.favourites
      @comments = @carprofile.comments.order("created_at desc")
      
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

def post_comment
    @carprofile = Carprofile.find_by_id(params[:car_profile_id])
    @carprofile.favourites.each do |n|
      @notification = Notification.create(:user_id => current_user.id, :notification_type => "carprofile_comment", :notifiable_id  => n.user_id)
    end
    @abuse_report = AbuseReport.new

    if params[:body].present?
      @comment = Comment.add_comment(params[:body],current_user,@carprofile)
      @class = rate_count(@carprofile.id)[0] rescue ""
      #raise @class.inspect
      if @comment.save
        
        @success = "Comment Saved Successfully !!!"
      end
    else
       @error = "Please Enter Text In Body !!!"
    end
    @comments = @carprofile.comments.order("created_at desc")
  end

  def guest_user
    @carprofile = Carprofile.find(params[:id])
    @carprofile.impressions = @carprofile.impressions.order("created_at DESC") rescue ""
    @carprofile.visitor(@carprofile)
    @carprofile.impressions = @carprofile.impressions.delete_if {|i| i.user_id == current_user.id }
    @carprofile.impressions = @carprofile.impressions.destroy {|i| i.user_id == nil } 
    # @carprofile.impressions.each do |u|
    #     if u.user_id == nil
    #       u.destroy
    #     else

    #     end
    # end
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  end

  def destroy
    @carprofile = Carprofile.find(params[:id])
    @carprofile.destroy
    redirect_to carprofiles_path
  end

  def comment_destroy
   @comment = Comment.find(params[:id])
   @comment.destroy
   redirect_to :back,:notice => "Comment Deleted Successfully"
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