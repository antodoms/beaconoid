class AddAttachmentImageToAdvertisements < ActiveRecord::Migration[5.0]
  def self.up
    change_table :advertisements do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :advertisements, :image
  end
end
