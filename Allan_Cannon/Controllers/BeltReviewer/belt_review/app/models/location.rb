class Location < ActiveRecord::Base
  belongs_to :state

  validates :name, :state, presence: true
  validates_uniqueness_of :name, :scope => [:state]

  has_many :users
  has_many :events

end
