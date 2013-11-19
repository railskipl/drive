class LogbookCategory < ActiveRecord::Base
  attr_accessible :name


  has_many :logbooks

  validates_presence_of :name

end
