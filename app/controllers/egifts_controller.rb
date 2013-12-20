require 'will_paginate/array'

class EgiftsController < ApplicationController
  def index
  	@egifts = Egift.all
  	@category = EgiftCategory.all
    @send_gift = SendGift.new

  end
  
  def my_gifts
  	@send_gifts = current_user.received_egifts
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  	@public = @send_gifts.public_gift.paginate(page: params[:page], per_page: 2) 
  end

  def anonymous
    @send_gifts = current_user.received_egifts
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    @anon = @send_gifts.anonymous
  end

  def personal
    @send_gifts = current_user.received_egifts
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    @personal = @send_gifts.personal
  end

end
