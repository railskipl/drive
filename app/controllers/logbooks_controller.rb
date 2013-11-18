class LogbooksController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  def index
  	@logbooks = current_user.logbooks.all
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


  end

  def destroy
  	@logbook = Logbook.find(params[:id])
  	if @logbook.destroy

    	flash[:notice] = "Deleted successfully"
    	redirect_to logbooks_path
    end
  end
end
