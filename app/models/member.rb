class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #validates
  #name
  validates :first_name, presence: true, length: {maximum: 10}
  validates :last_name, presence: true, length: {maximum: 10}
  validates :first_name_kana, presence: true, length: {maximum: 10}
  validates :last_name_kana, presence: true, length: {maximum: 10}

  validates :telephone, length: {maximum: 15}
  validates :postal_code, presence: true, format: {with: /\A\d{7}\z/}
  validates :address, presence: true, length: {maximum: 100}
  validates :is_deleted, inclusion: {in: [true, false]}

  has_many :orders
  has_many :cart_products, dependent: :destroy
  has_many :destinations, dependent: :destroy

end