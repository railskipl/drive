class Admin::SeosController < ApplicationController
  before_filter :authenticate_admin!, :except => []
  layout 'admin'
  
  def index
     @seos = Seo.all
     respond_to do |format|
       format.html
     end
   end
   
   def edit
     @seo = Seo.find(params[:id])
   end
   
    def update
     @seo = Seo.find(params[:id])

     respond_to do |format|
       if @seo.update_attributes(params[:seo])
         format.html { redirect_to admin_seos_path, notice: 'seo was successfully updated.' }
         format.json { head :no_content }
       else
         format.html { render action: "edit" }
         format.json { render json: @seo.errors, status: :unprocessable_entity }
       end
     end
    end
end
