class Block < ActiveRecord::Base
  attr_accessible :blocker_id,:blockable_id,:blocker_type,:blockable_type
  def self.spam(blockable,blocker)
    self.find_or_create_by_blocker_id_and_blockable_id_and_blocker_type_and_blockable_type(blocker.id,blockable.id, blocker.class.table_name.classify, blockable.class.table_name.classify)
  end

  def self.remove_spam(blockable,blocker)
    record = blocked_records(blockable,blocker)
    if record.present?
    	record.map(&:destroy)
    end
  end

  def self.status(blockable,blocker)
    status = blocked_records(blockable,blocker)
    #binding.pry
    return !status.empty?
  end

  def self.list_of_blocked_users(blocker)
    self.where("blocker_id = ? and blocker_type = ?", blocker.id,blocker.class.table_name.classify)
  end


  private

  def self.blocked_records(blockable,blocker)
  	record = self.where("blocker_id =? and blockable_id = ? and blocker_type = ? and blockable_type = ?",blocker.id,blockable.id,blocker.class.table_name.classify,blockable.class.table_name.classify)
  end


end
