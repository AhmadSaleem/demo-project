class AddShippingAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :shipping_address, :string, limit: 100
  end
end
