class UsersController < ApplicationController

  before_filter :authenticate_user!, only: [:dashboard]

  def dashboard
    @products = current_user.products.includes(:images).ordered.page(params[:page]).per(User::PER_PAGE_SIZE)
    @reviews = current_user.reviews.includes(:product).ordered.page(params[:page])
  end

  def show
    @user = User.includes(:image).find(params[:id])
    @products = @user.products.includes(:images).ordered.page(params[:page]).per(User::PER_PAGE_SIZE)
  end

end
