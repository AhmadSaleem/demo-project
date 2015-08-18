class AddNotNullToImages < ActiveRecord::Migration
  def change
    change_column :images, :photo_file_name, :string, null: false
  end
end
