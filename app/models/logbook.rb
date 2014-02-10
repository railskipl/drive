class Logbook < ActiveRecord::Base
  attr_accessible :body_index_id, :car_make_id, :car_model_id, :logbook_category_id, :logbook_discription, :user_id,:carprofile_id,:title

  belongs_to :car_make
  belongs_to :car_model
  belongs_to :body_index
  belongs_to :user
  belongs_to :carprofile
  belongs_to :logbook_category
  has_many :comment_logbooks, dependent: :destroy 
  has_many :favourites, dependent: :destroy

validates_presence_of :logbook_category_id,:logbook_discription,:carprofile_id,:title
  acts_as_likeable


extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged]

  def slug_candidates
    [     
      ["#{CarMake.find(car_make_id).name}","#{CarModel.find(car_model_id).name}","#{BodyIndex.find(body_index_id).bodyindex}", "#{LogbookCategory.find(logbook_category_id).name}", "#{(title)}"]
    ]
  end
  

  def likes(id)

    Like.find_all_by_likeable_id_and_likeable_type(id,self.class)
  end

  def sum_counts(count)
  	
   count.inject{|sum,x| sum + x }
  end
end
