class Message < ActiveRecord::Base
  attr_accessible :body, :is_deleted_by_recipient, :is_deleted_by_sender, :is_read, :is_trashed_by_recipient, :subject,:sender_id,:recipient_id,:user_tokens

  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'
  has_many :users
  attr_reader :user_tokens

    def user_tokens=(ids)
        self.user_ids = ids.split(",")
    end

end
