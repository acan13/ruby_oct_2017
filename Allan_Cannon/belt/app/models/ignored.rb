class Ignored < ActiveRecord::Base
  belongs_to :ignorer, class_name: "User", foreign_key: "ignorer_id"
  belongs_to :ignoree, class_name: "User", foreign_key: "ignoree_id"

  validates_uniqueness_of :ignorer, scope: :ignoree
end
