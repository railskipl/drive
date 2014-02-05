class UsersController < ApplicationController
	layout 'admin'
  require 'will_paginate/array'
   helper_method :resource, :resource_name, :devise_mapping
   before_filter :authenticate_admin!, :except => [:user_emails,:show,:subscribe_profile,:friend_request,:block_user,:unblock_user,:blocked_users,:change_status,:user_friends,:user_cars,:user_gifts]
   before_filter :authenticate_admin!, :only => [:new,:update,:edit, :user_birthday]
   helper :friendships
   before_filter :authenticate_user!, :only => [:blocked_users, :show, :user_cars, :user_friends, :friend_request]

  def index
   @search = User.search(params[:q])
   @users = @search.result.find(:all, :order => "created_at DESC")
   @users = @users.paginate(page: params[:page], per_page: 100)
    #@users = User.find(:all, :order => "created_at DESC")
  end

  def user_emails
  @users = User.order(:email)
    respond_to do |format|
    format.json { render json: @users.json_tokens(params[:q])}
    end
  end

  # def user_birthday
  #   @user = User.all.find_all {|u| u.birthday_today?}
  #   #raise @user.inspect
  # end

   def new
    #raise "hi"
    @user = User.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }

    end
  end

  def create
    #raise "hello"
    @user = User.create(params[:user])
    raise @user.inspect
    if @user.save
       flash[:notice] = "successfully added user"
       redirect_to users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def addpoints
    @users = User.all
    
    if params[:id]
      @user = User.find_by_id(params[:id])
      #raise params[:add].inspect
    end
    
  end

  def addedpoints
      
     if params[:id]
       @user = User.find_by_id(params[:id])
     end
    #raise @user.buycredit.inspect
    @user.freecredit = @user.freecredit.to_i + params[:add].to_i
    @user.credit = @user.freecredit.to_i + @user.buycredit.to_i
    #raise @user.credit.inspect
     # @user.update_column(:freecredit,params[:freecredit])
     # @user.update_column(:credit,params[:credit])
     @user.save!
    redirect_to users_path
  end

  def update
    #raise "hi"
    @user = User.find(params[:id])
    #raise @user.inspect
    if @user.update_attributes(params[:user])
      flash[:notice] = "successfully updated #{@user.email} credit"
      redirect_to users_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path
      flash[:notice] = "Destroyed successfully"
    end
  end

  def toggled_status
    @user = User.find(params[:id])
    @user.status = !@user.status?
    @user.save!
    redirect_to users_path
  end

  def show
    @user = User.find(params[:id])
    
    @logged_in_user = current_user 
    @cars = @user.carprofiles
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    render :layout => "application"
  end

def subscribe_profile
   @user = User.find(params[:id])
  if Subscriber.subscribes?(current_user,@user)
    Subscriber.unsubscribe!(current_user,@user)
  else
    Subscriber.subscribe!(current_user,@user)
  end
    respond_to do |format|
     format.js {}
    end
 end


  def friend_request
     @user = User.find(params[:id])
     unless current_user == @user
       redirect_to root_url, :notice => "Access Denied"
     end
      render :layout => "application"
  end

 def block_user
  @user = User.find(params[:id])
  Block.spam(@user,current_user)
 end

 def unblock_user
   @user = User.find(params[:id])
   Block.remove_spam(@user,current_user)
 end


 def blocked_users
   @blocked_users = Block.list_of_blocked_users(current_user)
   render :layout => 'application'
 end

  def change_status
   if params[:status]== "INVISIBLE"
  
     unless current_user.credit < 10
      updated_on =(Date.parse(DateTime.now.to_s) - Date.parse(current_user.visibility_updated_on.to_s)).to_i
      if updated_on < 10
        current_user.update_attribute("visibility_status",false)
      else
        current_user.update_attribute("credit",current_user.credit-10)
        current_user.update_attributes(:visibility_status => false,:visibility_updated_on => DateTime.now)
      end
     end
   else
     current_user.update_attribute("visibility_status",true)
   end

   render :json => {:status => current_user.visibility_status,:credit => current_user.credit}.to_json
   
  end



def user_friends
  @user = User.find(params[:id])
  @logged_in_user = current_user 
  @friends = @user.friends
  render :layout => "application"
end

def user_cars
  @user = User.find(params[:id])
  @carprofiles = @user.carprofiles
  render :layout => "application"
end

def user_gifts
  @user = User.find(params[:id])
  @gifts = @user.received_egifts
  @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  @public = @gifts.public_gift
  @anon = @gifts.anonymous
  @personal = @gifts.personal 
  render :layout => "application"
end

end

