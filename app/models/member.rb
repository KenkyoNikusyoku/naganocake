class Member < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
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

  def Member.new_token
    SecureRandom.urlsafe_base64
  end

  def Member.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def create_reset_digest
    self.reset_token = Member.new_token
    update_attribute(:reset_digest,  Member.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    MemberMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
end