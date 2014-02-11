class UserBlog < ActiveRecord::Base
  attr_accessible :blog_id, :body,:user_id,:title

  belongs_to :blog
  belongs_to :user
  has_many :blog_comments, dependent: :destroy
  has_many :favourites, dependent: :destroy

  validates_presence_of :blog_id, :body,:user_id,:title

  acts_as_likeable

  extend FriendlyId
  friendly_id :title, use: [:slugged]

  

  def likes(id)
    Like.find_all_by_likeable_id(id) rescue nil
  end

  def sum_counts(count)
   count.inject{|sum,x| sum + x }
  end
end
