class User < ActiveRecord::Base
  belongs_to :location
  has_one :state, through: :location


  validates :first_name, :last_name, presence: true
  validates_email_format_of :email
  validates :email, uniqueness: true
  validates :location_id, presence: true
  has_secure_password on: :create

  has_many :events, dependent: :destroy
  has_many :attendings
  has_many :events_attending, through: :attendings, source: :event

  has_many :comments
end
