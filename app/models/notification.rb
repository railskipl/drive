class Notification < ActiveRecord::Base
  attr_accessible :is_read, :notifiable_id, :notification_type, :user_id

  belongs_to :user
end
