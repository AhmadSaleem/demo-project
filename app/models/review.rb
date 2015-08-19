class Review < ActiveRecord::Base

  attr_accessible :body

  belongs_to :product
  belongs_to :user

  validates :body, presence: true, length: { minimum: 20 }

end
