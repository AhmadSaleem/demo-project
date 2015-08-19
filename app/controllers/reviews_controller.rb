class ReviewsController < ApplicationController

  before_filter :set_product

  before_filter :set_review, only: [:show, :edit, :update, :destroy]

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
    @review = @product.reviews.create(params[:review])
    respond_to do |format|
      if @review.save
        format.html { redirect_to [@product, @review], notice: 'Review was successfully created.' }
      else
        format.html { render action: "edit" }
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
end
