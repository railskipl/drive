class SendGiftsController < ApplicationController
  # GET /send_gifts
  # GET /send_gifts.json
  def index
       @send_gifts = current_user.sent_egifts
    @received_gifts = current_user.received_egifts

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @send_gifts }
    end
  end

  # GET /send_gifts/1
  # GET /send_gifts/1.json
  def show
    @send_gift = SendGift.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @send_gift }
    end
  end

  # GET /send_gifts/new
  # GET /send_gifts/new.json
  def new
    @send_gift = SendGift.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @send_gift }
    end
  end

  # GET /send_gifts/1/edit
  def edit
    @send_gift = SendGift.find(params[:id])
  end

  # POST /send_gifts
  # POST /send_gifts.json
  def create
    @send_gift = SendGift.new(params[:send_gift])

    respond_to do |format|
      if @send_gift.save
        format.html { redirect_to @send_gift, notice: 'Send gift was successfully created.' }
        format.json { render json: @send_gift, status: :created, location: @send_gift }
      else
        format.html { render action: "new" }
        format.json { render json: @send_gift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /send_gifts/1
  # PUT /send_gifts/1.json
  def update
    @send_gift = SendGift.find(params[:id])

    respond_to do |format|
      if @send_gift.update_attributes(params[:send_gift])
        format.html { redirect_to @send_gift, notice: 'Send gift was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @send_gift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /send_gifts/1
  # DELETE /send_gifts/1.json
  def destroy
    @send_gift = SendGift.find(params[:id])
    @send_gift.destroy

    respond_to do |format|
      format.html { redirect_to send_gifts_url }
      format.json { head :no_content }
    end
  end
end
