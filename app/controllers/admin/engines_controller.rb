class Admin::EnginesController < ApplicationController
  before_filter :authenticate_admin!, :except => []
  layout 'admin'
  def index
  	@engines = Engine.all
  end

  def new
  	@engine = Engine.new
  end

  def create
  	@engine = Engine.new(params[:engine])

  	if @engine.save
  		redirect_to admin_engines_path
  	else
  		render :new
  	end
  end

  def update
  	@engine = Engine.find(params[:id])
    if @engine.update_attributes(params[:engine])
    	flash[:notice] = "Engine displacement updated successfully."
    	redirect_to admin_engines_path
    else
    	render :new
    end

  end

  def edit
  	@engine = Engine.find(params[:id])
  end

  def destroy
    @engine = Engine.find(params[:id])
       if @engine.destroy
        flash[:notice] = "Engine Deleted Successfully"
        redirect_to admin_engines_path
      end
  end
end
