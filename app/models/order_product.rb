class OrderProduct < ApplicationRecord
	belongs_to :product
	belongs_to :order_product

    enum work_status:{
        disable: 1,
        wait: 2,
        working: 3,
        done: 4
    }

    with_options presence: true do
        validates :product_id
        validates :order_id
        validates :price
        validates :quantity
        validates :work_status
    end
end
