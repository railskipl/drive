class SendGift < ActiveRecord::Base
  attr_accessible :carprofile_id, :egift_id, :message, :sender_id ,:receiver_id,:visibility_id
  belongs_to :carprofile
  belongs_to :egift
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  belongs_to :visibility


  def self.public_gift
  	find_all_by_visibility_id(1)
  end

  def self.personal
  	find_all_by_visibility_id(2)
  end

  def self.anonymous
  	find_all_by_visibility_id(3)
  end


end
