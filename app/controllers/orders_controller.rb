class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def new
    @order = Order.new
    @order.total_price = cookies[:payable_amount]
    @order.discount = cookies[:discount]
    @order.shipping_address = current_user.shipping_address
  end

  def create
    @order = current_user.orders.new(params[:order])
    @order.total_price = cookies[:payable_amount]

    begin
      charge = Order.charge(cookies[:payable_amount], params[:order][:stripe_card_token], current_user)

    rescue Stripe::CardError => e
      render :new
      return
    end

    if @order.save
      current_user.shipping_address = params[:order][:shipping_address] unless current_user.shipping_address == params[:order][:shipping_address]
      current_user.save
      OrderProduct.save_details(@cart, @order)
      payment_info = { user: @current_user, total: cookies[:payable_amount], discount: cookies[:discount] }
      UserMailer.send_receipt(payment_info).deliver
      cookies.delete :products
      redirect_to products_path, notice: "Thank you for buying!"
    else
      render :new, notice: "Error"
    end
  end
end

