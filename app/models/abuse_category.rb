class AbuseCategory < ActiveRecord::Base
  attr_accessible :name

  belongs_to :abuse_category
end
