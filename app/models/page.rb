class Page < ActiveRecord::Base
  attr_accessible :body, :title,:meta_title, :meta_description, :meta_keyword
  validates_presence_of  :body,:title
end
