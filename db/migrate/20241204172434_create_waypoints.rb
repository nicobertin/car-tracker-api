class CreateWaypoints < ActiveRecord::Migration[7.2]
  def change
    create_table :waypoints do |t|
      t.float :latitude
      t.float :longitude
      t.datetime :sent_at
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
