class Invitation < ActiveRecord::Base
  belongs_to :inviter, class_name: "User", foreign_key: "inviter_id"
  belongs_to :invitee, class_name: "User", foreign_key: "invitee_id"

  validates_uniqueness_of :inviter, scope: :invitee
end
