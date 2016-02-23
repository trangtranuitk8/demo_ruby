class AddUploadImage < ActiveRecord::Migration
  def up
    add_attachment :products, :upload_image
  end

  def down
    remove_attachment :products, :upload_image
  end
end
