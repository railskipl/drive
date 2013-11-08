class CarModel < ActiveRecord::Base
  attr_accessible :car_make_id, :engine_displacement, :name
end
