class AddNicknameAndNameToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :nickname, :string
  	add_column :users, :name, :string
  end
end
