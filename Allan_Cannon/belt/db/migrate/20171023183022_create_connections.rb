class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.references :connector, index: true
      t.references :connectee, index: true

      t.timestamps null: false
    end
  end
end
