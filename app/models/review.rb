class Review < ActiveRecord::Base

  paginates_per 5

  attr_accessible :body

  belongs_to :product
  belongs_to :user

  validates :body, presence: true, length: { minimum: 20 }

  scope :ordered, -> { order("created_at desc") }

end
