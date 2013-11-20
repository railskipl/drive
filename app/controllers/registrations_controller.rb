class RegistrationsController < Devise::RegistrationsController

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


end
 