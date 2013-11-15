class BodyIndex < ActiveRecord::Base
  attr_accessible :bodyindex, :car_model_id

  belongs_to :car_model
end
