ActiveAdmin.register Product do

  actions :all, :except => [:edit]

  index do
    column :id
    column :title
    column :body
    column :price, sortable: :price do |product|
    number_to_currency product.price
  end

  column :created_at

  column :reviews do |review|
    link_to "reviews", admin_product_reviews_path(review)
  end

  column :images do |image|
    link_to "images", admin_product_images_path(image)
  end

  default_actions
  end

end
