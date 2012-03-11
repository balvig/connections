class CreateConnectionsConnections < ActiveRecord::Migration
  def change
    create_table :connections_connections do |t|
      t.integer :connector_id
      t.integer :connectable_id
      t.string :connector_type
      t.string :connectable_type
      t.string :type

      t.timestamps
    end
  end
end
