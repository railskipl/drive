class RegistrationsController < Devise::RegistrationsController
layout :custom_layout
 
 def edit
  super
  end

def create

	day =  params["user"]["birthday(1i)"] + "-" +params["user"]["birthday(2i)"] + "-" +params["user"]["birthday(3i)"]
	
	unless day >  Date.today.strftime("%Y-%m-%d")
      if simple_captcha_valid?
         super
      else
         build_resource
         clean_up_passwords(resource)
         flash[:notice] = "There was an error with the captcha code below. Please re-enter the code and click submit."
         render :new
      end
     else
     	  build_resource
         clean_up_passwords(resource)
         flash[:notice] = "Wrong Birth Date"
         render :new
     end
    
  end

  def update
    day =  params["user"]["birthday(1i)"] + "-" +params["user"]["birthday(2i)"] + "-" +params["user"]["birthday(3i)"]
     unless day >  Date.today.strftime("%Y-%m-%d")
      super
     else
       flash[:notice] = "Wrong Birth Date"
       render :edit
     end
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

private

   def custom_layout

    if  params[:action] == "edit" || params[:action] == "update"
      "application"
    else
      "devise/registrations"
    end
   end


end
 