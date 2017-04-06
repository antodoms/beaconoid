class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :unique_id
      t.string :image_url

      t.references :created_by
	  t.references :modified_by

      t.timestamps
    end
  end
end
