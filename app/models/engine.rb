class Engine < ActiveRecord::Base
  attr_accessible :car_make_id, :car_model_id, :engine_displacement

  belongs_to :car_model
  has_many :carprofiles
end
