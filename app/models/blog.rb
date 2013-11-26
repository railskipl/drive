class Blog < ActiveRecord::Base
  attr_accessible :name
   validates_presence_of :name

   has_many :user_blogs
   has_many :favourites
end
