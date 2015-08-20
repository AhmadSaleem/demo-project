class Product < ActiveRecord::Base

  PER_PAGE_SIZE = 5

  attr_accessible :body, :price, :title, :images_attributes

  has_many :images, as: :imageable, dependent: :destroy
  has_many :reviews, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :user

  validates :title, presence: true, length: { minimum: 5 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.1 }

  scope :ordered, -> { order("created_at desc") }

end
