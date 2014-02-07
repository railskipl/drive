class NewCarsController < ApplicationController
	helper_method  :total_rating_count
	before_filter :authenticate_user!
  def index
  	    @spotlighted_cars = Carprofile.where("spotlighted = ?",true)

  	@car_photo = Carprofile.order("created_at desc").limit(100)
  end

protected

  def total_rating_count(carprofile_id)
    carprofile = Carprofile.find(carprofile_id)
    count = 0
    count += carprofile.send_gifts.count rescue 0
    count += Like.find_all_by_likeable_type_and_likeable_id("Carprofile",carprofile.id).map(&:count).inject(:+).nil? ? 0 : Like.find_all_by_likeable_type_and_likeable_id("Carprofile",carprofile.id).map(&:count).inject(:+) rescue 0
    count += carprofile.comments_count rescue 0
    count += carprofile.logbooks.count rescue 0
    count += carprofile.favourites.count rescue 0
    count += Subscriber.find_all_by_subscribable_id(carprofile.id).count rescue 0
    count += Carprofile.find(carprofile.id).spotlighted ? 1 : 0  rescue 0
  end


end
