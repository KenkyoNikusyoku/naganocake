class OrderProduct < ApplicationRecord
	belongs_to :product
	belongs_to :order

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

    def subtotal
        self.quantity * self.price
    end

    def auto_update_order_status
        parent_order = self.order
        brothers_order_products = parent_order.order_products
        brothers_work_statuses = brothers_order_products.map{ |op| op.work_status_before_type_cast }
        if  brothers_work_statuses.include?(3)
            parent_order.update(status: 3)
        elsif brothers_work_statuses.all?{ |ws| ws == 4 }
            parent_order.update(status: 4)
        end
    end
end
