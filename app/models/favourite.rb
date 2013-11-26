class Favourite < ActiveRecord::Base
  attr_accessible :favourite_type, :favourite_type_id, :is_read, :user_id, :logbook_id, :user_blog_id

  belongs_to :logbook
  belongs_to :user_blog
  belongs_to :logbook_category
  belongs_to :blog
end
