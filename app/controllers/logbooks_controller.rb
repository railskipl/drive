class LogbooksController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  def index
  	@logbooks = current_user.logbooks.all
    #raise @logbooks.inspect
  end

  def new
  	@logbook = Logbook.new
  end

  def create
  	@logbook = Logbook.create(params[:logbook])
  	if @logbook.save
  		flash[:notice] = "Logbook created successfully"
  		redirect_to logbooks_path
  	else
  		render :new
  	end
  end

  def edit
    @logbook = Logbook.find(params[:id])
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
end
