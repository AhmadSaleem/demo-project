module ProductsHelper
  def render_description(product)
    return "No description found." if product.body.blank?
    return product.body
  end
end
