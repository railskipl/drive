class Admin::CreditsController < ApplicationController

  before_filter :authenticate_admin!, :except => []
  layout 'admin'
	def index
		@credit = Credit.first
	    if @credit.nil?
	      @credit = Credit.new(:credit => 0, :free_credit => 0)
	      @credit.save
	    end
	    @credit_package = CreditPackage.new
	    @credit_packages = CreditPackage.all
	end
    
	def update
	    @credit = Credit.find(params[:id])
		if @credit.update_attributes(params[:credit])
          flash[:notice] = "Credit Saved Successfully"
	      redirect_to admin_credit_packages_path
	    else
          flash[:notice] = "Fields Cannot Be Empty"
	      redirect_to admin_credit_packages_path
        end
    end
end
