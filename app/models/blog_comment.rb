class BlogComment < ActiveRecord::Base
  attr_accessible :body, :user_blog_id, :user_id

  belongs_to :user_blog
  belongs_to :user

  validates_presence_of :body
end
