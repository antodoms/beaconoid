class Advertisements < ActiveRecord::Migration[5.0]
  def self.up
  	create_table :advertisements do |t|
  		t.column :aId, :string
  		t.column :aCategory, :string
  		t.column :aPrice, :float
  		t.column :aDescription, :text
  	end
  end

  def self.down
  	drop_table :advertisements
  end
  
end
