class CommentLogbook < ActiveRecord::Base
  attr_accessible :body, :logbook_id, :user_id

  belongs_to :logbook
end
