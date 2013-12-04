class Engine < ActiveRecord::Base
  attr_accessible :engine_displacement
  validates_presence_of :engine_displacement
end
