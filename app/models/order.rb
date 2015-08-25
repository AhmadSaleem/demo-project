class Order < ActiveRecord::Base

  attr_accessible :discount, :total_price, :user_id

  belongs_to :user

end
