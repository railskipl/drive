class Egift < ActiveRecord::Base
  attr_accessible :credit,:image
  validates_presence_of :credit,:image
  has_attached_file :image, :styles => { :thumb => "100x100", :medium => "350x350"},
                   :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "public/attachments/egift/:id/:style/:basename.:extension",
                    
                    :convert_options => {
                          :thumb => "-compose Copy -gravity center -extent 100x100",
                          :medium => "-compose Copy -gravity center -extent 350x350",
                          
                      }
end
