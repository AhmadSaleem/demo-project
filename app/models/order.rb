class Order < ActiveRecord::Base

  attr_accessible :discount, :total_price, :user_id

  belongs_to :user
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  validates :discount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

end
