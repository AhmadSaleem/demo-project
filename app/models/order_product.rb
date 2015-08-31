class OrderProduct < ActiveRecord::Base

  attr_accessible :order_id, :product_id

  belongs_to :order
  belongs_to :product

  def self.save_details(cart, order)

    cart.each do |product|
      order_product = order.order_products.new
      order_product.product_id = product
      order_product.save
    end

  end

end
