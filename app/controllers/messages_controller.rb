class MessagesController < ApplicationController
  before_filter :authenticate_user!
  # GET /messages
  # GET /messages.json
  def index
    @messages = current_user.recipient_messages
    @messages.delete_if {|i| i.is_deleted_by_recipient == true } 
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])
    if @message.sender == current_user
       respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @message }
       end  
    else
        if @message.is_deleted_by_recipient == true 
           redirect_to messages_url  
        else
          respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @message }
          end
        end
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    @msg = Message.new(params[:message])
    recipients_array = params[:message][:user_tokens].split(",").collect {|s| s.to_i}
    recipients_array.each do |r|
     @message = Message.create(:subject => @msg.subject, :body => @msg.body,
      :sender_id => current_user.id, :recipient_id => r )
    end
    respond_to do |format|
      if @message.save
        format.html { redirect_to sent_messages_messages_path, notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
     @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  def trash
    @message = Message.find(params[:id])
    if @message.is_trashed_by_recipient == true
      @message.is_trashed_by_recipient = false
      @message.save
    else
      @message.is_trashed_by_recipient = true
      @message.save
    end
    redirect_to messages_url
  end

    def destroy_recipient
    @message = Message.find(params[:id])
    if @message.is_deleted_by_recipient == false
      @message.is_deleted_by_recipient = true
      @message.save
    end
    # @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  def trash_messages
    @messages = current_user.recipient_messages
    @messages.delete_if {|i| i.is_deleted_by_recipient == true } 
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  end

  def sent_messages
    @sent_messages = current_user.sent_messages rescue nil
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  end

  def sent_all_to_trash_recipient
   message =  Message.where(:id => params[:message_ids])
   message.each do |r|
    if r.is_trashed_by_recipient == true
      r.is_trashed_by_recipient = false
      r.save
    else
      r.is_trashed_by_recipient = true
      r.save
    end
   end
   redirect_to messages_url
   end
  
end
