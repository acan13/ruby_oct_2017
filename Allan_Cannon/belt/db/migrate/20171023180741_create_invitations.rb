class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :inviter, index: true
      t.references :invitee, index: true

      t.timestamps null: false
    end
  end
end
