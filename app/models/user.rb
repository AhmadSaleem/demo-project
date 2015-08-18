class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  has_one :image, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :image
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :image_attributes

  def fetch_image
    self.image.present? ? self.image : self.build_image
  end
end
