class AddSalesToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :sales, :string
  end
end
