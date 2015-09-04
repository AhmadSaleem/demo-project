class UserMailer < ActionMailer::Base

  default from: "admin@virtualbazar.com"

  def send_receipt(params)
    @user = params[:user]
    @total_price = params[:total]
    @discount = params[:discount]
    mail(to: @user.email, subject: "Payment Receipt")
  end

end
