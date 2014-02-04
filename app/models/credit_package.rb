class CreditPackage < ActiveRecord::Base
  attr_accessible :name,:package_type,:points_field, :amount, :custom_field, :link
  validates_presence_of :points_field, :amount, :custom_field, :link

end
