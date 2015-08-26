class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_size
  before_filter :get_cart

  def is_valid?(user)
    current_user == user
  end

  def get_products(array)
    ActiveSupport::JSON.decode(array)
  end

  def get_size
    return @size = 0 unless cookies[:products]
    @size = get_products(cookies[:products]).size
  end

  def get_cart
    @cart = get_products(cookies[:products]) if cookies[:products]
  end

end
