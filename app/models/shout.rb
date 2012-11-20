class Shout < ActiveRecord::Base
  attr_accessible :message, :created_at, :user_id

  belongs_to :user

  # validates_existence_of :user, :both => false
end
