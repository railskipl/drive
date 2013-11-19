class Credit < ActiveRecord::Base
  attr_accessible :credit, :free_credit
  validates_presence_of :credit ,:free_credit
end
