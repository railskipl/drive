class HomeController < ApplicationController
  def index
  end

  def contact
    if request.post? and params[:reset_password]
            if contact = Contact.new(params[:reset_password])
              contact.name = "#{params[:reset_password][:name]}"
              contact.email = "#{params[:reset_password][:email]}"
           
              contact.subject = "#{params[:reset_password][:subject]}"
              contact.message = "#{params[:reset_password][:message]}"
              if contact.save
              ContactMailer.registration_confirmation(contact).deliver
              flash[:notice] = "Thank You for contacting us. We will reach you back shortly."
              redirect_to("/contact")
              end
            end
	         else
	           @title = "contacts"
	         end
    end

def search
q = params[:q]
@q = User.search(first_name_or_last_name_or_location_cont: q)
@users=@q.result(:distinct => true)

end


end
