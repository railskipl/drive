class Contactadmin < ActiveRecord::Base
  attr_accessible :message, :subject
end
