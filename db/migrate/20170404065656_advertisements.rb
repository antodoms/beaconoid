class Advertisements < ActiveRecord::Migration[5.0]
  def self.up
  	create_table :advertisements do |t|
      t.string :name
      
      t.references :beacon
      t.references :category
  		t.float :price
  		t.string :description

      t.references :created_by
      t.references :modified_by

      t.timestamps
  	end

  end

  def self.down
  	drop_table :advertisements
  end
  
end
