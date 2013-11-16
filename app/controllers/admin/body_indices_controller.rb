class Admin::BodyIndicesController < ApplicationController
  before_filter :authenticate_admin!, :except => []
  layout 'admin'
  def index
   @body_indices = BodyIndex.all
  end

  def new
  	@body_index = BodyIndex.new
  end

  def create
  	@body_index = BodyIndex.new(params[:body_index])

  	if @body_index.save
  		flash[:notice] = "Created Successfully"
  		redirect_to admin_body_indices_path
  	else 
  		render :new
  	end
  end

  def update
  	@body_index = BodyIndex.find(params[:id])
  	if @body_index.update_attributes(params[:body_index])
  		flash[:notice] = "Updated Successfully"
  		redirect_to admin_body_indices_path
  	else
  		render :new
  	end
  	
  end

  def destroy
  	@body_index = BodyIndex.find(params[:id])
  	if @body_index.destroy
  		flash[:notice] = "Deleted Successfully"
  		redirect_to admin_body_indices_path
  	end
  end
end
