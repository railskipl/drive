class Admin::BodyIndicesController < ApplicationController
  before_filter :authenticate_admin!, :except => []
  layout 'admin'
  def index
   @body_indices = BodyIndex.all
  end

  def new
  	@body_index = BodyIndex.new
  end

  def edit
   @body_index = BodyIndex.find(params[:id])  
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
      if params[:type] == "Update Body Index"
       redirect_to manage_bodyindices_path
      else
  		 redirect_to admin_body_indices_path
      end
  	else
  		render :new
  	end
  	
  end

  def destroy
    raise params.inspect
  	@body_index = BodyIndex.find(params[:id])
  	if @body_index.destroy
  		flash[:notice] = "Deleted Successfully"
      if params[:type] == "body_index"
        redirect_to manage_bodyindices_path
      else
  		  redirect_to admin_body_indices_path
      end
  	end
  end
end
