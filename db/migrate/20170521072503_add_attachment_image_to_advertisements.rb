class AddAttachmentImageToAdvertisements < ActiveRecord::Migration[5.0]
  def up
    add_attachment :advertisements, :image
  end

  def down
    remove_attachment :advertisements, :image
  end
end
