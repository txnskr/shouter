class Shout < ActiveRecord::Base
  attr_accessible :message
  attr_accessible :created_at 
end
