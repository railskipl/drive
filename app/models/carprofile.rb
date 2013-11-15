class Carprofile < ActiveRecord::Base
  attr_accessible :car_make_id, :car_model_id, :manufacturing_year, :whatkindofcar, :year_of_purchase, :car_description,
                  :power, :sellthiscar, :license_plate, :VIN, :user_id, :engine_id, :carprofile_photo_id,
                  :carprofile_photos_attributes, :body_index_id

  belongs_to :user
  belongs_to :car_make
  belongs_to :car_model
  belongs_to :engine
  has_many :carprofile_photos

  accepts_nested_attributes_for :carprofile_photos, :reject_if => lambda { |a| a[:photo].blank? }, :allow_destroy => true,limit: 10
end
