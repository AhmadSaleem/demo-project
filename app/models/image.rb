class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  # Paperclip
  has_attached_file :photo,
    styles: {
      small: "100",
      full: "400",
    }

  validates_attachment_content_type :photo, content_type: 'image/jpeg'
  attr_accessible :imageable_id, :imageable_type, :photo_content_type, :photo_file_name, :photo_file_size, :photo
end