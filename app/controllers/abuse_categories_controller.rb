class AbuseCategoriesController < ApplicationController
  before_filter :authenticate_admin!
  layout "admin"

  # GET /abuse_categories
  # GET /abuse_categories.json
  def index
    @abuse_categories = AbuseCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @abuse_categories }
    end
  end

  # GET /abuse_categories/1
  # GET /abuse_categories/1.json
  def show
    @abuse_category = AbuseCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @abuse_category }
    end
  end

  # GET /abuse_categories/new
  # GET /abuse_categories/new.json
  def new
    @abuse_category = AbuseCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @abuse_category }
    end
  end

  # GET /abuse_categories/1/edit
  def edit
    @abuse_category = AbuseCategory.find(params[:id])
  end

  # POST /abuse_categories
  # POST /abuse_categories.json
  def create
    @abuse_category = AbuseCategory.new(params[:abuse_category])

    respond_to do |format|
      if @abuse_category.save
        format.html { redirect_to @abuse_category, notice: 'Abuse category was successfully created.' }
        format.json { render json: @abuse_category, status: :created, location: @abuse_category }
      else
        format.html { render action: "new" }
        format.json { render json: @abuse_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /abuse_categories/1
  # PUT /abuse_categories/1.json
  def update
    @abuse_category = AbuseCategory.find(params[:id])

    respond_to do |format|
      if @abuse_category.update_attributes(params[:abuse_category])
        format.html { redirect_to @abuse_category, notice: 'Abuse category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @abuse_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /abuse_categories/1
  # DELETE /abuse_categories/1.json
  def destroy
    @abuse_category = AbuseCategory.find(params[:id])
    @abuse_category.destroy

    respond_to do |format|
      format.html { redirect_to abuse_categories_url }
      format.json { head :no_content }
    end
  end
end
