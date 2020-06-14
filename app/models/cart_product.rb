class CartProduct < ApplicationRecord

	belongs_to :member
    belongs_to :product
    with_options presence: true do
        validates :member_id
        validates :product_id
        validates :quantity
      end
end
