class SendGift < ActiveRecord::Base
  attr_accessible :carprofile_id, :egift_id, :message, :sender_id ,:receiver_id,:visibility_id
  belongs_to :carprofile
  belongs_to :egift
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  belongs_to :visibility


  def self.public_gift
  	find_all_by_visibility_id_and_status(1,true,:order => "created_at desc")
  end

  def self.personal
  	find_all_by_visibility_id_and_status(2,true,:order => "created_at desc")
  end

  def self.anonymous
  	find_all_by_visibility_id_and_status(3,true,:order => "created_at desc")
  end


  def self.public_gift2
    find_all_by_visibility_id_and_status(1,false,:order => "created_at desc")
  end

  def self.personal2
    find_all_by_visibility_id_and_status(2,false,:order => "created_at desc")
  end

  def self.anonymous2
    find_all_by_visibility_id_and_status(3,false,:order => "created_at desc")
  end


end
