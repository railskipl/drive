class AbuseReport < ActiveRecord::Base
  attr_accessible :abuse_category_id, :abuse_type, :abuser_user_id, :carprofile_id, :comment_id, :comments, :logbook_id, :user_blog_id, :user_id
  
  validates_presence_of :abuse_category_id
  belongs_to :abuse_category
  belongs_to :user
end

