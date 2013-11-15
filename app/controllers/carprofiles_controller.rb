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

  def edit
  	@carprofile = Carprofile.find(params[:id])
  end

  def show
  	@carprofile = Carprofile.find(params[:id])
  end
end