class CartProduct < ApplicationRecord
	with_options presence: true do
        validates :member_id
        validates :product_id
        validates :quantity
    end
end
