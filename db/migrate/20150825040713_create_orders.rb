class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.float :total_price
      t.float :discount
      t.integer :user_id

      t.timestamps
    end
  end
end
