class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
    	t.string :name
	    t.string :description

	    t.references :created_by
	    t.references :modified_by

      	t.timestamps
    end
  end
end
