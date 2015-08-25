class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
      t.integer :order_id, index: true
      t.integer :product_id, index: true

      t.timestamps
    end
  end
end
