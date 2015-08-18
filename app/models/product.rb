class Product < ActiveRecord::Base

  has_many :images, as: :imageable, dependent: :destroy

  attr_accessible :body, :price, :title, :images_attributes

  accepts_nested_attributes_for :images, allow_destroy: true

end
