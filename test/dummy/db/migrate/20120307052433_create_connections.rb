class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.string :type
      t.string :connectable_type
      t.integer :connectable_id
      t.string :connector_type
      t.integer :connector_id

      t.timestamps
    end
  end
end
