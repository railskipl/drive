class Notification < ActiveRecord::Base
  attr_accessible :is_read, :notifiable_id, :notification_type, :user_id,:receiver_id,:rate_count
  belongs_to :receiver, :class_name => 'User'

  belongs_to :user
end
