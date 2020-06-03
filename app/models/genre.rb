class Genre < ApplicationRecord
	has_many :products

	validates :name, presence:true
	validates :is_valid, presence:true
end
