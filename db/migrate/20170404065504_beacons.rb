class Beacons < ActiveRecord::Migration[5.0]
  def self.up
    create_table :beacons do |t|
      t.references :store
      t.string :name
      t.string :current_status
      t.string :unique_reference
      t.string :latitude
      t.string :longitude

      t.references :created_by
      t.references :modified_by

      t.timestamps
    end

  end

  def self.down
    drop_table :beacons
  end


end
