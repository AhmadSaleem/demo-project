class User < ActiveRecord::Base

  PER_PAGE_SIZE = 9

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :image_attributes, :shipping_address

  has_one :image, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :image
  has_many :products, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy

  def fetch_image
    self.image.present? ? self.image : self.build_image
  end

end
