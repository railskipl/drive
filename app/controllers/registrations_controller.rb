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

private

   def custom_layout

    if  params[:action] == "edit" || params[:action] == "update"
      "application"
    else
      "devise/registrations"
    end
   end


end
 