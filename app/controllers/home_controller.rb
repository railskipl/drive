class HomeController < ApplicationController

  def index
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    @user_blogs = current_user.user_blogs.all
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
@spotlighted_cars = Carprofile.where("spotlighted = ?",true)
q = params[:q]
@q = User.search(first_name_or_last_name_or_location_or_email_cont: q)
@users=@q.result(:distinct => true)
end

def keywordsearch
q = params[:q]
@users = User.search(first_name_or_last_name_or_nickname_or_location_or_email_cont: q).result
@user_blogs = UserBlog.search(title_cont: q).result
@logbooks = Logbook.search(title_cont: q).result
@carprofiles = Carprofile.search(license_plate_or_engine_dis_or_power__or_cont: q).result
@favourites =  Favourite.search(favourite_type_cont: q).result
end

def subscribe_count
  @user = User.find(params[:id])
  @subscribers =  Subscriber.subscribers(@user,User)
end

end
