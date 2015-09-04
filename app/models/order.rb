class Order < ActiveRecord::Base

  attr_accessible :discount, :total_price, :user_id, :stripe_card_token, :shipping_address
  attr_accessor :stripe_card_token

  belongs_to :user
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  validates :discount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :shipping_address, presence: true

  def self.charge(total, token, user)
    Stripe::Charge.create(
      amount: (total.to_f * 100).to_i,
      currency: "usd",
      source: token,
      receipt_email: user.email,
    )
  end

end
