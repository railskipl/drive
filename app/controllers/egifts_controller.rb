class EgiftsController < ApplicationController
  def index
  	@egifts = Egift.all
  	@category = EgiftCategory.all
   @send_gift = SendGift.new
  end
  def my_gifts
  	@send_gifts = current_user.received_egifts
  end
end
