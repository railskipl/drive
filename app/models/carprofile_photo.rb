class CarprofilePhoto < ActiveRecord::Base
  attr_accessible :carprofile_id, :photo

  belongs_to :carprofile

  validates_presence_of :photo

  has_attached_file :photo,:styles => { :thumb => "176x100", :medium => "480x270>", :profile => "130x126"},
                   :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "public/attachments/car/:id/:style/:basename.:extension",
                    
                    :convert_options => {
                          :thumb => "-compose Copy -gravity center -extent 176x100",
                          :medium => "-compose Copy -gravity center -extent 350x350",
                          
                      }

  validates_attachment :photo, content_type: { content_type: ['image/jpeg', 'image/GIF'] }
end
