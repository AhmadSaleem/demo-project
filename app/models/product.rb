class Product < ActiveRecord::Base

  PER_PAGE_SIZE = 5

  has_many :images, as: :imageable, dependent: :destroy

  attr_accessible :body, :price, :title, :images_attributes

  accepts_nested_attributes_for :images, allow_destroy: true

  scope :ordered, -> { order("created_at desc") }

end
