class State < ActiveRecord::Base
  has_many :locations
  has_many :events, through: :locations

  has_many :users, through: :locations
end
