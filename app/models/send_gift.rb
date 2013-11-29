class SendGift < ActiveRecord::Base
  attr_accessible :carprofile_id, :egift_id, :message, :sender_id ,:receiver_id
  belongs_to :carprofile
  belongs_to :egift
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  validates_presence_of :message
end
