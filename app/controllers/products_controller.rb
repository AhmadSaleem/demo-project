class ProductsController < ApplicationController
  before_filter :set_product, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :authorize_user, only: [:edit, :update, :destroy]

  respond_to :html

  def index
    @products = Product.perform_search(params)
    respond_with(@products)
  end

  def show
    @review = Review.new
    respond_with(@product)
  end

  def new
    @product = Product.new
    respond_with(@product)
  end

  def edit
  end

  def create
    @product = Product.new(params[:product])
    @product.user_id = current_user.id
    @product.save
    respond_with(@product)
  end

  def update
    @product.update_attributes(params[:product])
    respond_with(@product)
  end

  def destroy
    @product.destroy
    respond_with(@product)
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def authorize_user
      redirect_to products_path, notice: "Only the product owner can perform this action." unless is_valid?(@product.user)
    end
end
