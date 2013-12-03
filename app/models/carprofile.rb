class Carprofile < ActiveRecord::Base
  attr_accessible :car_make_id, :car_model_id, :manufacturing_year, :whatkindofcar, :year_of_purchase, :car_description,
                  :power, :sellthiscar, :license_plate, :VIN, :user_id, :engine_id, :carprofile_photo_id,
                  :carprofile_photos_attributes, :body_index_id

  belongs_to :user
  belongs_to :body_index
  belongs_to :car_make
  belongs_to :car_model
  belongs_to :engine
  has_many :send_gifts
  has_many :carprofile_photos

  validates_presence_of :year_of_purchase,:license_plate,:sellthiscar,:car_description,:power,:whatkindofcar,:manufacturing_year,:car_make_id,:car_model_id,:body_index_id

  accepts_nested_attributes_for :carprofile_photos, :reject_if => lambda { |a| a[:photo].blank? }, :allow_destroy => true,limit: 10
  
  acts_as_likeable

  def likes(id)
    Like.find_all_by_likeable_id(id) rescue nil
  end

  def sum_counts(count)
   count.inject{|sum,x| sum + x }
  end

def self.spotlight(car_profile)
  car_profile.update_attribute("spotlighted",!car_profile.spotlighted)
  return car_profile.spotlighted
 end
 
  def self.remove_subscribables(subscriber)
          self.where(:subscriber_type => subscriber.class.name.classify).
               where(:subscriber_id => subscriber.id).destroy_all
        end

  
end
