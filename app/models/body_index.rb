class BodyIndex < ActiveRecord::Base
  attr_accessible :bodyindex, :car_model_id

  belongs_to :car_model
  has_many :logbooks
  validates_presence_of :bodyindex

end
