class Comment < ActiveRecord::Base
  attr_accessible :body, :carprofile_id,:user_id
  belongs_to :carprofile,:counter_cache => true
  belongs_to :user

  def self.add_comment(body,user,carprofile)
  	self.create(:carprofile_id => carprofile.id,:body => body, :user_id => user.id)
  end
end
