class Message < ActiveRecord::Base
  attr_accessible :body, :is_deleted_by_recipient, :is_deleted_by_sender, :is_read, :is_trashed_by_recipient, :subject,:sender_id,:recipient_id,:user_tokens,:message_id

  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'
  belongs_to :message
  has_many :users
  attr_reader :user_tokens

    def user_tokens=(ids)
        self.user_ids = ids.split(",")
    end

      def subject_name(sub)
      if sub["Re"]
      	return sub
      else
      	return "Re:" + sub
      end
    end

    def msg(id)
    raise id.inspect
      self.message_id = id
    end

end
