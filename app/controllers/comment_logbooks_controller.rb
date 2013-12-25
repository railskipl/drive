class CommentLogbooksController < ApplicationController
  before_filter :authenticate_user!, :except => []
  # GET /comment_logbooks
  # GET /comment_logbooks.json
  def index
    @comment_logbooks = current_user.comment_logbooks.all
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comment_logbooks }
    end
  end

  # GET /comment_logbooks/1
  # GET /comment_logbooks/1.json
  def show
        @logbook = Logbook.find(params[:id])

    @comment_logbook = CommentLogbook.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment_logbook }
    end
  end

  # GET /comment_logbooks/new
  # GET /comment_logbooks/new.json
  def new
    @comment_logbook = CommentLogbook.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment_logbook }
    end
  end

  # GET /comment_logbooks/1/edit
  def edit
    @comment_logbook = CommentLogbook.find(params[:id])
  end

  # POST /comment_logbooks
  # POST /comment_logbooks.json
  def create
    @comment_logbook = CommentLogbook.new(params[:comment_logbook])
    #raise @comment_logbook.logbook.user_id.inspect
      if @comment_logbook.save
        @notification = Notification.new(:user_id => current_user.id, :notification_type => "logbook_comment", :notifiable_id  => @comment_logbook.logbook.user_id)
        @notification.save
        flash[:notice] = 'Comment logbook was successfully created.' 
        redirect_to logbook_path(@comment_logbook.logbook_id)
      else
        flash[:notice] = 'Comment can not be blank.'
        redirect_to logbook_path(@comment_logbook.logbook_id)
      end
  end

  # PUT /comment_logbooks/1
  # PUT /comment_logbooks/1.json
  def update
    @comment_logbook = CommentLogbook.find(params[:id])

    respond_to do |format|
      if @comment_logbook.update_attributes(params[:comment_logbook])
        format.html { redirect_to @comment_logbook, notice: 'Comment logbook was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment_logbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comment_logbooks/1
  # DELETE /comment_logbooks/1.json
  def destroy
    @comment_logbook = CommentLogbook.find(params[:id])
    @comment_logbook.destroy

    respond_to do |format|
      format.html { redirect_to logbook_path(@comment_logbook.logbook_id) }
      format.json { head :no_content }
    end
  end
end
