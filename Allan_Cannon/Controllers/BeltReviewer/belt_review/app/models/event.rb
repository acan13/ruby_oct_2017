class Event < ActiveRecord::Base
  belongs_to :location
  has_one :state, through: :location

  belongs_to :user

  validates :name, :user, :location, presence: true
  # need to add date and date validation

  has_many :attendings
  has_many :attendees, through: :attendings, source: :user

  has_many :comments
end
