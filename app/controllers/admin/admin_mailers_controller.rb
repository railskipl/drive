class Admin::AdminMailersController < ApplicationController
before_filter :authenticate_admin!, :except => []
  layout 'admin'
	
	def admin_mailer
		if request.post? and params[:reset_password]


            if admin_mailer = AdminMailer.new(params[:reset_password])
            	#raise admin_mailer.inspect
              admin_mailer.name = "#{params[:reset_password][:name]}"
              admin_mailer.email = "#{params[:reset_password][:email]}"
           
              #admin_mailer.subject = "#{params[:reset_password][:subject]}"
              admin_mailer.message = "#{params[:reset_password][:message]}"
              if admin_mailer.save
              AdminMailerMailer.registration(admin_mailer).deliver
              flash[:notice] = "Thank You for contacting us. We will reach you back shortly."
              redirect_to("/admin/admin_mailer")
              end
            end
	         else
	           @title = "admin_mailers"
	         end
	end
end
