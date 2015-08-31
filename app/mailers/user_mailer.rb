class UserMailer < ActionMailer::Base

  default from: "ahmad.saleem@square63.com"

  def send_receipt(params)
    @user = params[:user]
    @total_price = params[:total]
    @discount = params[:discount]
    mail(to: @user.email, subject: "Payment Receipt")
  end

end
