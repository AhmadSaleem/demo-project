ActiveAdmin.register Image do
  belongs_to :product, parent_class: Product
end
