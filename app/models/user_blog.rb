class UserBlog < ActiveRecord::Base
  attr_accessible :blog_id, :body,:user_id

  belongs_to :blog
  belongs_to :user
  has_many :blog_comments, dependent: :destroy
  has_many :favourites, dependent: :destroy

  validates_presence_of :blog_id, :body,:user_id

  acts_as_likeable

  def likes(id)
    Like.find_all_by_likeable_id(id) rescue nil
  end

  def sum_counts(count)
   count.inject{|sum,x| sum + x }
  end
end
