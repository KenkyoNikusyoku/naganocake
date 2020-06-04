class Order < ApplicationRecord
	belongs_to :member
    has_many :order_products

    enum payment_option: {
		bank_transfer: 1,
		credit_card: 2
	}

		enum order_status: {
		unpaid: 1,
		paid: 2,
		working: 3,
		ready: 4,
		shipped: 5
	}

	with_options presence: true do
		validates :member_id
		validates :receiver
		validates :postal_code
		validates :address
		validates :payment_option
		validates :status
		validates :postage
		validates :billing
	end

	validates :postal_code, format: {with: /\A\d{7}\z/}
end
