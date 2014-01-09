require 'will_paginate/array'

class EgiftsController < ApplicationController
before_filter :authenticate_user!
  def index
  	@egifts = Egift.all
  	@category = EgiftCategory.all
    @send_gift = SendGift.new

  end
  
  def my_gifts
  	@send_gifts = current_user.received_egifts
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  	@public = @send_gifts.public_gift.paginate(page: params[:page], per_page: 5) 
  end

  def anonymous
    @send_gifts = current_user.received_egifts
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    @anon = @send_gifts.anonymous.paginate(page: params[:page], per_page: 5) 
  end

  def personal
    @send_gifts = current_user.received_egifts
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
    @personal = @send_gifts.personal.paginate(page: params[:page], per_page: 5) 
  end

  def egift_notifications
    @send_gifts = current_user.received_egifts
    @public = @send_gifts.public_gift2 
    @anon = @send_gifts.anonymous2
    @personal = @send_gifts.personal2
    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)
  end

end
