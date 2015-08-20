class ReviewsController < ApplicationController

  before_filter :set_product

  before_filter :set_review, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :create_authorization, only: [:new, :create]
  before_filter :edit_authorization, only: [:edit, :update]
  before_filter :destroy_authorization, only: [:destroy]

  respond_to :html

  def index
    @reviews = @product.reviews
  end

  def show
  end

  def new
    @review = @product.reviews.build
  end

  def edit
  end

  def create
    @review = @product.reviews.build(params[:review])
    @review.user_id = current_user.id
    respond_to do |format|
      if @review.save
        format.html { redirect_to @product, notice: 'Review was successfully created.' }
        format.js
      else
        format.html { render action: "edit" }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to [@product, @review], notice: 'Review was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @review.destroy
    redirect_to product_reviews_path
  end

  private
    def set_review
      @review = @product.reviews.where(id: params[:id]).last
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    def create_authorization
      redirect_to product_reviews_path, notice: "Product's owner cannot review their own product." if is_valid?(@product.user)
    end

    def edit_authorization
      redirect_to product_reviews_path, notice: "Only the owner of this review can edit this review." unless is_valid?(@review.user)
    end

    def destroy_authorization
      redirect_to product_reviews_path, notice:"You are not authorized to perform this action." unless is_valid?(@review.user) || is_valid?(@product.user)
    end

    def is_valid?(user)
      current_user == user
    end

end
