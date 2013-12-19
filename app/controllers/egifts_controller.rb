class EgiftsController < ApplicationController
  def index
  	@egifts = Egift.all
  	@category = EgiftCategory.all
    @send_gift = SendGift.new

  end
  def my_gifts
  	@send_gifts = current_user.received_egifts
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  	@public = @send_gifts.public_gift
    @personal = @send_gifts.anonymous
    @anon = @send_gifts.personal
  end
end
