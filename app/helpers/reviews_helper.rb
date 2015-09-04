module ReviewsHelper

  def render_review(review)
    review.body.truncate(200)
  end

end
