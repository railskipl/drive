class CreditsController < ApplicationController
  before_filter :authenticate_user!
  def earn_credits
    @credit = Credit.first
    @credit_packages = CreditPackage.all
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  end

  def get_credits
        @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
        #"status"=>"VALID"
       #raise params[:status].inspect
    unless params[:status] == "VALID"
      flash[:notice] = "Access Denied"
      redirect_to root_path
    else
      if params[:custom1] == "1001"
         current_user.buycredit = current_user.buycredit.to_i + 10
         current_user.credit = current_user.freecredit + current_user.buycredit
         current_user.save
      elsif params[:custom1] == "1002"
        current_user.buycredit = current_user.buycredit.to_i + 20
        current_user.credit = current_user.freecredit + current_user.buycredit
        current_user.save
      elsif params[:custom1] == "1000"
        current_user.buycredit = current_user.buycredit.to_i + 50
        current_user.credit = current_user.freecredit + current_user.buycredit
        current_user.save
      end
    end
    
    # @credit = Credit.first
    #  current_user.buycredit = current_user.buycredit.to_i + (params[* @credit.credit)
    #  current_user.credit = current_user.freecredit + current_user.buycredit
    #  current_user.save
    # redirect_to earn_credits_credits_path
  end


  def select_package

    @credit_packages = CreditPackage.all
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  end
end
