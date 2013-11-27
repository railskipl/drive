class Engine < ActiveRecord::Base
  attr_accessible :engine_displacement
  has_many :carprofiles
  validates_presence_of :engine_displacement
end
