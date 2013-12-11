class UsersController < ApplicationController
	layout 'admin'
   before_filter :authenticate_admin!, :except => [:user_emails,:show,:subscribe_profile,:friend_request]
    helper :friendships

  def index
    @users = User.all
  end

  def user_emails
  @users = User.order(:email)
    respond_to do |format|
    format.json { render json: @users.json_tokens(params[:q])}
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



end
