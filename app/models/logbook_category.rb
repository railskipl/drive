class LogbookCategory < ActiveRecord::Base
  attr_accessible :name


  has_many :logbooks
  has_many :favourites

  validates_presence_of :name

end
