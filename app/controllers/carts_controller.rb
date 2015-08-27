class CartsController < ApplicationController
  before_filter :fetch_product, only: [:add_to_cart, :remove_from_cart]
  before_filter :calculate_amounts, only: [:show, :discount]

  def show
    @products = Product.find(get_products(cookies[:products])) if cookies[:products]
    @discount = Discount.new
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
    calculate_amounts
  end

  def discount
    calculate_amounts
    respond_to do |format|
      format.html { redirect_to carts_show_path }
      format.js
    end

  end

  private
    def calculate_amounts
      @total_price = Product.find(get_products(cookies[:products])).sum(&:price) if cookies[:products]
      @total_discount = Discount.calculate_discount(params, @total_price)
      @payable_amount = @total_price.to_i - @total_discount
    end

    def fetch_product
      @product = Product.find(params[:product_id])
    end

    def add_product(array)
      ActiveSupport::JSON.encode(array)
    end
end
