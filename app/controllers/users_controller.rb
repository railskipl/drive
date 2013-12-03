class UsersController < ApplicationController
	layout 'admin'
   before_filter :authenticate_admin!, :except => [:show,:subscribe_profile]

  def index
  	@users = User.all
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




end
