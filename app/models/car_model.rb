class CarModel < ActiveRecord::Base
  attr_accessible :car_make_id, :engine_displacement, :name
  belongs_to :car_make
  has_many :body_indices, dependent: :destroy
  has_many :carprofiles, dependent: :destroy

  has_many :logbooks, dependent: :destroy

  validates_presence_of :name

end
