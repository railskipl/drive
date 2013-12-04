class CommentLogbook < ActiveRecord::Base
  attr_accessible :body, :logbook_id, :user_id
  validates_presence_of :body, :logbook_id, :user_id
  belongs_to :logbook
  belongs_to :user
end
