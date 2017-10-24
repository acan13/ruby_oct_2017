class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, :last_name, :email, presence: true
  validates :password, presence: true, on: :create
  validates :email, uniqueness: true
  validates_email_format_of :email

  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :liked, through: :likes, source: :secret


  before_validation :email_to_lowercase

  private

  def email_to_lowercase
    self.email.downcase!
  end
end
