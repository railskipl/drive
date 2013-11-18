class CarMake < ActiveRecord::Base
  attr_accessible :name
  has_many :car_models,  dependent: :destroy
  has_many :carprofiles
<<<<<<< HEAD
  has_many :logbooks
=======
  validates_presence_of :name

>>>>>>> a4a2c2ed64a148de9a63f96f3a649879ba6ca98e
end
