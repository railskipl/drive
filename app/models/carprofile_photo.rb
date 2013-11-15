class CarprofilePhoto < ActiveRecord::Base
  attr_accessible :carprofile_id, :photo

  belongs_to :carprofile

  has_attached_file :photo,:styles => { :thumb => "100x100", :medium => "480x270>"}

  validates_attachment :photo, content_type: { content_type: ['image/jpeg', 'image/GIF'] }
end
