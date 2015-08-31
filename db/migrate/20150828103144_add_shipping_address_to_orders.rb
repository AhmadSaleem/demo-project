class AddShippingAddressToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_address, :string, limit: 100
  end
end
