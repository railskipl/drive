class Admin::CreditPackagesController < ApplicationController
  before_filter :authenticate_admin!, :except => []
  layout 'admin'

  def index
  	@credit_packages = CreditPackage.all
  	@credit = Credit.first
	    if @credit.nil?
	      @credit = Credit.new(:credit => 0, :free_credit => 0)
	      @credit.save
	    end
	    @credit_package = CreditPackage.new
	    @credit_packages = CreditPackage.all
  end

  def new
  	@credit_package = CreditPackage.new
  end

  def show
    @credit_package = CreditPackage.find(params[:id])
  end

  def create
    @credit_package = CreditPackage.new(params[:credit_package])
    if @credit_package.save
	 	flash[:notice] = "Credit Package Created Successfully"
        redirect_to admin_credit_packages_path
    else
        render :new
    end
  end

  def edit
      @credit_package = CreditPackage.find(params[:id])
    end

    def update
      @credit_package = CreditPackage.find(params[:id])
      if @credit_package.update_attributes(params[:credit_package])
        flash[:notice] = "Credit Package Saved Successfully"
        redirect_to admin_credit_packages_path
      else
        render :new
      end
    end
    

    def destroy
      @credit_package = CreditPackage.find(params[:id])
     
      if @credit_package.destroy
        flash[:notice] = "Credit Package Deleted Successfully"
        redirect_to admin_credit_packages_path
      end
      
    end
end
