class LogbookCategory < ActiveRecord::Base
  attr_accessible :name

  has_many :logbooks
end
