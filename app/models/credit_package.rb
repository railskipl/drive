class CreditPackage < ActiveRecord::Base
  attr_accessible :name,:package_type
  validates_presence_of :name, :package_type

end
