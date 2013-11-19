class CarMake < ActiveRecord::Base
  attr_accessible :name
  has_many :car_models,  dependent: :destroy
  has_many :carprofiles, dependent: :destroy
  has_many :logbooks, dependent: :destroy

  validates_presence_of :name

end
