class Product < ActiveRecord::Base

  PER_PAGE_SIZE = 9

  attr_accessible :body, :price, :title, :images_attributes

  has_many :images, as: :imageable, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :order_products, dependent: :destroy
  has_many :orders, through: :order_products
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :user

  validates :title, presence: true, length: { minimum: 5 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.1 }

  scope :ordered, -> { order("created_at desc") }

  define_index do
    indexes title, sortable: true
    indexes body
    set_property delta: true
  end

  def self.perform_search(options)
    options = {} if options.blank?
    search_params  = default_search_options(options)
    self.search options[:search], search_params
  end

  def self.default_search_options(options)
    {
      order: "id DESC",
      page: options[:page],
      per_page: PER_PAGE_SIZE,
    }
  end

end
