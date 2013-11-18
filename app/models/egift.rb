class Egift < ActiveRecord::Base
  attr_accessible :credit,:image
  has_attached_file :image
  validates_presence_of :credit
end
