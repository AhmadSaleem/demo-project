class Image < ActiveRecord::Base

  attr_accessible :imageable_id, :imageable_type, :photo_content_type, :photo_file_name, :photo_file_size, :photo

  belongs_to :imageable, polymorphic: true
  has_attached_file :photo,
    styles: {
      small: "100x100#",
      full: "400x400#",
    },
    default_url: 'default_:style.jpg'

  validates_attachment_content_type :photo, content_type: 'image/jpeg'
  validates :photo, presence: true

end
