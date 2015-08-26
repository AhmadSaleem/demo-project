class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.string :coupon, limit: 50
      t.float :percentage
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
