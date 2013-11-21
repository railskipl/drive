class EgiftCategory < ActiveRecord::Base
  attr_accessible :name
  has_many :egifts,dependent: :destroy
end
