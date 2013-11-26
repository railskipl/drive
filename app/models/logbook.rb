class Logbook < ActiveRecord::Base
  attr_accessible :body_index_id, :car_make_id, :car_model_id, :logbook_category_id, :logbook_discription, :user_id

  belongs_to :car_make
  belongs_to :car_model
  belongs_to :body_index
  belongs_to :user
  belongs_to :logbook_category
  has_many :comment_logbooks, dependent: :destroy 
  has_many :favourites

validates_presence_of :car_make_id,:car_model_id,:body_index_id,:logbook_category_id,:logbook_discription
  acts_as_likeable

  def likes(id)

    Like.find_all_by_likeable_id_and_likeable_type(id,self.class)
  end

  def sum_counts(count)
  	
   count.inject{|sum,x| sum + x }
  end
end
