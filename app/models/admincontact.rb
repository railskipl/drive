class Admincontact < ActiveRecord::Base
  attr_accessible :carmake, :carmodel, :emailid, :enginedis

  validates_presence_of :carmake, :carmodel, :emailid, :enginedis

end
