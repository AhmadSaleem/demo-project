class CartsController < ApplicationController
  before_filter :fetch_product, only: [:add_to_cart, :remove_from_cart]
  before_filter :set_price, only: [:show]

  def show
    @products = Product.find(get_products(cookies[:products])) if cookies[:products]
  end

  def add_to_cart
    if cookies[:products]
      cart = get_products(cookies[:products])
      cookies[:products] = { value: add_product(cart.push(@product.id))} unless cart.include?(@product.id.to_s)
    else
      cookies[:products] = { value: add_product([@product.id]) }
    end

    get_size

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end

  end

  def remove_from_cart
    if cookies[:products]
      cart = get_products(cookies[:products])
      cookies[:products] = { value: add_product(cart -= [@product.id])} if cart.include?(@product.id)
    end

    get_size
    set_price
  end

  private
    def set_price
      @total_price = Product.find(get_products(cookies[:products])).sum(&:price) if cookies[:products]
    end

    def fetch_product
      @product = Product.find(params[:product_id])
    end

    def add_product(array)
      ActiveSupport::JSON.encode(array)
    end
end
