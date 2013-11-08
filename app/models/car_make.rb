class CarMake < ActiveRecord::Base
  attr_accessible :name
  has_many :car_models,  dependent: :destroy
end
