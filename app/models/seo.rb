class Seo < ActiveRecord::Base
  attr_accessible :meta_description, :meta_keyword, :meta_title
  validates_presence_of :meta_description, :meta_keyword,:meta_title
end
