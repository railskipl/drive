class CarModel < ActiveRecord::Base
  attr_accessible :car_make_id, :engine_displacement, :name
  belongs_to :car_make
  has_many :body_indices
  has_many :carprofiles
  has_many :engines
  has_many :logbooks
end
