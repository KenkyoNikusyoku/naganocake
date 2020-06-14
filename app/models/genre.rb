class Genre < ApplicationRecord
	has_many :products

	validates :name, presence:true
	validates :is_valid, inclusion: {in: [true, false]}
	
end
