class Admin::CreditsController < ApplicationController

  before_filter :authenticate_admin!, :except => []
  layout 'admin'
	def index
		@credit = Credit.first
	    if @credit.nil?
	      @credit = Credit.new(:credit => 0, :free_credit => 0)
	      @credit.save
	    end
	end
    
	def update
	    @credit = Credit.find(params[:id])
	    @credit.update_attributes(params[:credit])
	    redirect_to admin_credits_path
    end
end
