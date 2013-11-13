class CreditsController < ApplicationController
  def earn_credits
    @credit = Credit.first

  end

  def get_credits
  	@credit = Credit.first
    current_user.buycredit = current_user.buycredit.to_i + (params[:dollars].to_i * @credit.credit)
    current_user.credit = current_user.freecredit + current_user.buycredit
    current_user.save
    redirect_to earn_credits_credits_path
  end
end
