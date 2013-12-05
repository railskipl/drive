class Comment < ActiveRecord::Base
  attr_accessible :body, :commentable_id,:commentable_type,:user_id
	def self.add_comment(body,user,commentable)
  	self.create(:commentable_id => commentable.id,:body => body, :user_id => user.id,:commentable_type => commentable.class.table_name.classify )
  end
end
