module ProductsHelper

  def render_description(product)
    return "No description found." if product.body.blank?
    return product.body
  end

  def render_title(product)
    product.title.truncate(15)
  end

end
