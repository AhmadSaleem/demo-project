module ReviewsHelper
  def render_review(review)
    return review.body[0..499] + "..." if review.body.length > 500
    return review.body
  end
end
