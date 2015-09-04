module ApplicationHelper

  def authorized_user?(user)
    user_signed_in? && current_user == user
  end

  def render_name(user)
    [user.first_name, user.last_name].join(" ").titleize
  end

  def render_photo(image)
    return Image::DEFAULT_URL if image.blank?
    image.photo.url(:small)
  end

  def render_large_photo(image)
    return Image::DEFAULT_URL if image.blank?
    image.photo.url(:full)
  end

end
