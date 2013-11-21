class Favourite < ActiveRecord::Base
  attr_accessible :favourite_type, :favourite_type_id, :is_read, :user_id
end
