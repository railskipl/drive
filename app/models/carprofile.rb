class Carprofile < ActiveRecord::Base
  attr_accessible :car_make_id, :car_model_id, :manufacturing_year, :whatkindofcar, :year_of_purchase, :car_description,
                  :power, :sellthiscar, :license_plate, :VIN, :user_id, :engine_dis, :carprofile_photo_id,
                  :carprofile_photos_attributes, :body_index_id,:user_visit

  belongs_to :user
  belongs_to :body_index
  belongs_to :car_make
  belongs_to :car_model
  has_many :send_gifts, dependent: :destroy
  has_many :favourites,dependent: :destroy
  has_many :carprofile_photos, dependent: :destroy
  has_many :logbooks, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates_length_of :car_description,:maximum => 2000


  validates_presence_of :year_of_purchase,:license_plate,:sellthiscar,:car_description,:power,:whatkindofcar,:manufacturing_year,:car_make_id,:car_model_id,:body_index_id

  accepts_nested_attributes_for :carprofile_photos, :reject_if => lambda { |a| a[:photo].blank? }, :allow_destroy => true,limit: 10
  
  acts_as_likeable

  is_impressionable :counter_cache => true, :column_name => :user_visit,:unique => :session_hash
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
  def visitor(carprofile)
    
    carprofile.impressions.each do |imp|
     
      a = Time.now
      if a > imp.created_at
        c = a.to_date - (imp.created_at).to_date
        
        if c >= 30
          imp.destroy
        else
        
        end
      end
    end
  end
end
