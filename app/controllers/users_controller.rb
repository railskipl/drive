class UsersController < ApplicationController
	layout 'admin'
   before_filter :authenticate_admin!, :except => []

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

end
