 require 'will_paginate/array'
 class HomeController < ApplicationController
   before_filter :authenticate_user!

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


def topcar
  @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  @top_cars = top_cars(Carprofile.all.map(&:id))
  @@cars = @top_cars.to_a
  @top_cars = @top_cars.to_a.paginate(:page => params[:page],:per_page => 10)  
end

 def paginate_top_car
 @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
 @top_cars = @@cars.paginate(:page => params[:page],:per_page => 3)
 render "topcar"

end



def logbooksearch_home
  @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  @logbook_categories = LogbookCategory.all
  
  carmake = params[:logbook][:car_make_id]
  carmodel =  params[:logbook][:car_model_id]
  lc = params[:logbook][:logbook_category_id_eq]

  if carmake.empty?
  @logbooks = Logbook.search(logbook_category_id_eq: lc).result.paginate(page: params[:page], per_page: 5) 
  elsif carmodel.nil?
    if lc.empty?
      @logbooks = Logbook.where("car_make_id = ? ", carmake).paginate(page: params[:page], per_page: 5) 
    else
      @logbooks = Logbook.where("car_make_id = ? and logbook_category_id = ?", carmake,lc).paginate(page: params[:page], per_page: 5) 
    end
  else
    if lc.empty?
      @logbooks = Logbook.search(car_make_id_eq: carmake).result.paginate(page: params[:page], per_page: 5)
    else
      @logbooks = Logbook.where("car_make_id = ? and car_model_id = ? and logbook_category_id = ?", carmake,carmodel,lc).paginate(page: params[:page], per_page: 5) 
    end 
  end
end


end
