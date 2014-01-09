class ContactadminsController < ApplicationController
  before_filter :authenticate_admin!, :except => []
  layout 'admin'
  # GET /contactadmins
  # GET /contactadmins.json
  def index
    @contactadmins = Contactadmin.find(:all, :order => "created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contactadmins }
    end
  end

  # GET /contactadmins/1
  # GET /contactadmins/1.json
  def show
    @contactadmin = Contactadmin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contactadmin }
    end
  end

  # GET /contactadmins/new
  # GET /contactadmins/new.json
  def new
    @contactadmin = Contactadmin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contactadmin }
    end
  end

  # GET /contactadmins/1/edit
  def edit
    @contactadmin = Contactadmin.find(params[:id])
  end

  # POST /contactadmins
  # POST /contactadmins.json
  def create
    @contactadmin = Contactadmin.new(params[:contactadmin])

    respond_to do |format|
      if @contactadmin.save
        #ContactadminMailer.send_replacement_request(@contactadmin)
        format.html { redirect_to @contactadmin, notice: 'Contactadmin was successfully created.' }
        format.json { render json: @contactadmin, status: :created, location: @contactadmin }
      else
        format.html { render action: "new" }
        format.json { render json: @contactadmin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contactadmins/1
  # PUT /contactadmins/1.json
  def update
    @contactadmin = Contactadmin.find(params[:id])

    respond_to do |format|
      if @contactadmin.update_attributes(params[:contactadmin])
        format.html { redirect_to @contactadmin, notice: 'Contactadmin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contactadmin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contactadmins/1
  # DELETE /contactadmins/1.json
  def destroy
    @contactadmin = Contactadmin.find(params[:id])
    @contactadmin.destroy

    respond_to do |format|
      format.html { redirect_to contactadmins_url }
      format.json { head :no_content }
    end
  end
end
