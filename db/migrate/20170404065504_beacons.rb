class Beacons < ActiveRecord::Migration[5.0]
  def self.up
  	create_table :beacons do |t|
  		t.column :bID, :string, :null => false
  		t.column :bStore, :string
  		t.column :aID, :string #, :null => false
  		t.column :bCategory, :string
  		t.column :bHits, :integer

  	end

  	add_index(:beacons, :bID)

  end

  def self.down
  	drop_table :beacons
  end


end
