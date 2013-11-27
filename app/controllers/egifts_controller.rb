class EgiftsController < ApplicationController
  def index
  	@egifts = Egift.all
  	@category = EgiftCategory.all
 
  end
end
