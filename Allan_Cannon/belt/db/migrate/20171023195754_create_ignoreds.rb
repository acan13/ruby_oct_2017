class CreateIgnoreds < ActiveRecord::Migration
  def change
    create_table :ignoreds do |t|
      t.references :ignorer, index: true
      t.references :ignoree, index: true

      t.timestamps null: false
    end
  end
end
