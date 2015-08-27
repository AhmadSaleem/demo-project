class Discount < ActiveRecord::Base

  def self.calculate_discount(coupon, total_price)
    return 0 unless coupon
    discount = Discount.find_by_coupon_and_active(coupon, true)
    return 0 if discount.blank?
    (discount.percentage * total_price)/100
  end

end
