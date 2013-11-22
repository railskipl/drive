class Logbook < ActiveRecord::Base
  attr_accessible :body_index_id, :car_make_id, :car_model_id, :logbook_category_id, :logbook_discription, :user_id

  belongs_to :car_make
  belongs_to :car_model
  belongs_to :body_index
  belongs_to :user
  belongs_to :logbook_category
  has_many :comment_logbooks
  has_many :favourites
end
