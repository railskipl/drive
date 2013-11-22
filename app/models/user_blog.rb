class UserBlog < ActiveRecord::Base
  attr_accessible :blog_id, :body,:user_id

  belongs_to :blog

  has_many :blog_comments
end
