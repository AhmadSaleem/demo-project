class Review < ActiveRecord::Base

  attr_accessible :body

  belongs_to :product

  validates :body, presence: true, length: { minimum: 20 }

end
