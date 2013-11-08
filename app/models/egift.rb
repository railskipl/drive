class Egift < ActiveRecord::Base
  attr_accessible :credit,:image
  has_attached_file :image
end
