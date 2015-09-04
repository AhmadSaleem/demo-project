class CartsController < ApplicationController

  before_filter :fetch_product,     only: [:add_to_cart, :remove_from_cart]
  before_filter :calculate_amounts, only: [:show, :discount]
  after_filter :discard_flash,      only: [:discount]

  def show
    @products = Product.find(get_products(cookies[:products])) if cookies[:products]
    @discount = Discount.new
  end

  def add_to_cart
    if cookies[:products]
      cart = get_products(cookies[:products])
      cookies[:products] = { value: add_product(cart.push(@product.id)) } unless cart.include?(@product.id.to_s)
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
      cookies[:products] = { value: add_product(cart -= [@product.id]) } if cart.include?(@product.id)
    end

    get_size
    calculate_amounts
  end

  def discount
    respond_to do |format|
      flash[:notice] = "Coupon is valid" unless @total_discount.zero?
      flash[:alert] = "Coupon is invalid" if @total_discount.zero?
      format.html { redirect_to carts_show_path }
      format.js
    end
  end

  private
    def calculate_amounts
      cookies[:coupon] = params[:discount][:coupon] if params[:discount]
      @total_price = 0 unless cookies[:products]
      @total_price = Product.find(get_products(cookies[:products])).sum(&:price) if cookies[:products]
      @total_discount = Discount.calculate_discount(cookies[:coupon], @total_price)
      cookies.delete :coupon if @total_discount.zero?
      @payable_amount = @total_price.to_f - @total_discount
      cookies[:payable_amount] = @payable_amount
      cookies[:discount] = @total_discount
    end

    def fetch_product
      @product = Product.find(params[:product_id])
    end

    def add_product(array)
      ActiveSupport::JSON.encode(array)
    end

    def discard_flash
      flash.discard if request.xhr?
    end

end
