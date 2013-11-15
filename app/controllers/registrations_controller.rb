class RegistrationsController < Devise::RegistrationsController

def create
      if simple_captcha_valid?
         super
      else
         build_resource
         clean_up_passwords(resource)
         flash[:error] = "There was an error with the captcha code below. Please re-enter the code and click submit."
         render :new
      end
    
    end


end
 