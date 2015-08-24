module ApplicationHelper
  def authorized_user?(user)
    user_signed_in? && current_user == user
  end

  def render_name(user)
    [user.first_name, user.last_name].join(" ")
  end

  def render_photo(image)
    return if image.blank?
    image.photo.url(:small)
  end

end
