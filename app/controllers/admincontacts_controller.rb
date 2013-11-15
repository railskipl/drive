class AdmincontactsController < ApplicationController
  
  def index
  	@admincontacts = Admincontact.all
  end

  def new
  	@admincontact = Admincontact.new
  end

  def create
  	@admincontact = Admincontact.new(params[:admincontact])
  	if @admincontact.save
       flash[:notice] = "Your message has been sended successfully"
       redirect_to new_carprofile_path
   else
   	   render :new
   end
  end

  def update
  	
  end

  def show
  	@admincontact = Admincontact.find(params[:id])
  end

  def destroy
  	@admincontact = Admincontact.find(params[:id])
  	if @admincontact.destroy
  		flash[:notice] = "deleted"
  	    redirect_to admincontacts_path
    end
  end
end
