class AbuseReportsController < ApplicationController
  before_filter :authenticate_admin!, :only => [:index, :show, :delete, :update, :edit]
  before_filter :authenticate_user! , :only => [:new]
  layout "admin"
  # GET /abuse_reports
  # GET /abuse_reports.json
  def index
    @abuse_reports = AbuseReport.find(:all , :order => "created_at DESC" )
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @abuse_reports }
    end
  end

  # GET /abuse_reports/1
  # GET /abuse_reports/1.json
  def show
    @abuse_report = AbuseReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @abuse_report }
    end
  end

  # GET /abuse_reports/new
  # GET /abuse_reports/new.json
  def new
    @abuse_report = AbuseReport.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @abuse_report }
    end
  end

  # GET /abuse_reports/1/edit
  def edit
    @abuse_report = AbuseReport.find(params[:id])
  end

  # POST /abuse_reports
  # POST /abuse_reports.json
  def create

    @abuse_report = AbuseReport.create(params[:abuse_report])
    unless @abuse_report.abuse_category_id == nil
    #raise @abuse_report.inspect
       @abuse_report.save
      if @abuse_report.abuse_type == "carprofile"
         flash[:notice] =  'Abuse report successfully  sent.'
         redirect_to carprofile_path(@abuse_report.carprofile_id)  
      elsif @abuse_report.abuse_type == "logbook"
         
          flash[:notice] =  'Abuse report successfully sent.'
          redirect_to logbook_path(@abuse_report.logbook_id)
      elsif @abuse_report.abuse_type == "user_blog" 
        
          flash[:notice] =  'Abuse report successfully sent.'
          redirect_to user_blog_path(@abuse_report.user_blog_id)
      elsif  @abuse_report.abuse_type == "On logbook Page"
          flash[:notice] =  'Abuse report successfully sent.'
          redirect_to logbook_path(@abuse_report.logbook_id)
      elsif @abuse_report.abuse_type == "On Blog Page" 
          flash[:notice] =  'Abuse report successfully sent.'
          redirect_to user_blog_path(@abuse_report.user_blog_id)
      else @abuse_report.abuse_type == "On Carprofile Page" 
          flash[:notice] =  'Abuse report successfully sent.'
          redirect_to carprofile_path(@abuse_report.carprofile_id)
      end
    else
       
       if @abuse_report.abuse_type == "carprofile"
         flash[:notice] = "Please specify the abuse category"
         redirect_to carprofile_path(@abuse_report.carprofile_id)  
      elsif @abuse_report.abuse_type == "logbook"
         
          flash[:notice] = "Please specify the abuse category"
          redirect_to logbook_path(@abuse_report.logbook_id)
      elsif @abuse_report.abuse_type == "user_blog" 
        
          flash[:notice] = "Please specify the abuse category"
          redirect_to user_blog_path(@abuse_report.user_blog_id)
      elsif  @abuse_report.abuse_type == "On logbook Page"
          flash[:notice] = "Please specify the abuse category"
          redirect_to logbook_path(@abuse_report.logbook_id)
      elsif @abuse_report.abuse_type == "On Blog Page" 
         flash[:notice] = "Please specify the abuse category"
          redirect_to user_blog_path(@abuse_report.user_blog_id)
      else @abuse_report.abuse_type == "On Carprofile Page" 
          flash[:notice] = "Please specify the abuse category"
          redirect_to carprofile_path(@abuse_report.carprofile_id)
      end
    end
  end

  # PUT /abuse_reports/1
  # PUT /abuse_reports/1.json
  def update
    @abuse_report = AbuseReport.find(params[:id])

    respond_to do |format|
      if @abuse_report.update_attributes(params[:abuse_report])
        format.html { redirect_to @abuse_report, notice: 'Abuse report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @abuse_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /abuse_reports/1
  # DELETE /abuse_reports/1.json
  def destroy
    @abuse_report = AbuseReport.find(params[:id])
    @abuse_report.destroy

    respond_to do |format|
      format.html { redirect_to abuse_reports_url }
      format.json { head :no_content }
    end
  end
end
