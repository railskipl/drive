class CreditsController < ApplicationController
  before_filter :authenticate_user!
  def earn_credits
    @credit = Credit.first
    @credit_packages = CreditPackage.all
    
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  end

  def get_credits
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    @credit_packages = CreditPackage.all
    @credit_packages.each do |pack|

      #raise session[:id].inspect
      if (params[:custom1] == "#{pack.custom_field}") and (params[:payment_id].to_s == session[:id].to_s)
       current_user.buycredit = current_user.buycredit.to_i + pack.points_field.to_i
       current_user.credit = current_user.freecredit + current_user.buycredit
       current_user.save
       session[:id] = nil
      end
    end
  end


  def select_package

    @credit_packages = CreditPackage.all
    session[:id] = srand
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  end
end
