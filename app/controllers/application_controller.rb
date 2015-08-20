class ApplicationController < ActionController::Base
  protect_from_forgery

  def is_valid?(user)
    current_user == user
  end

end
