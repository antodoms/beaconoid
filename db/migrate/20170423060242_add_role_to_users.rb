class AddRoleToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :role, :string
  	remove_column :users, :image
  end
end
