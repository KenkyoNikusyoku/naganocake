class Order < ApplicationRecord
	attr_accessor :radio_number, :destination_id

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

	def auto_update_work_status
		#注文ステータスが「入金確認」になったら注文商品の製作ステータスを全て「製作待ち」に。
		if self.status_before_type_cast == 2
			self.order_products.each do |op|
				op.update(work_status: 2)
			end
		end
	end
end
