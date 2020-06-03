class Destination < ApplicationRecord
	belongs_to :member

	#postal_code
	validates :postal_code, presence: true, format: {with: /\A\d{7}\z/}
	#address
	validates :address, presence: true, length: {maximum: 100}
	#receiver
	validates :receiver, presence: true, length: {maximum: 20}

end