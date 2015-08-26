class Discount < ActiveRecord::Base

  def self.calculate_discount(params, total_price)
    return 0 unless params[:discount]
    coupon = params[:discount][:coupon] if params[:discount]
    discount = Discount.find_by_coupon_and_active(coupon, true)
    return 0 if discount.blank?
    (discount.percentage * total_price)/100
  end

end
