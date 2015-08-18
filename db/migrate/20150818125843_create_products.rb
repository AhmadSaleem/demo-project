class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title, limit: 120, null: false
      t.text :body
      t.float :price, null: false

      t.timestamps
    end
  end
end
