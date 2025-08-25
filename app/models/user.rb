# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  # Add these cart associations
  has_many :cart_items, dependent: :destroy
  has_many :cart_products, through: :cart_items, source: :product
  has_many :orders, dependent: :destroy

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Methods
  def full_name
    "#{first_name} #{last_name}".strip
  end

  def admin?
    admin
  end

  # Add these cart methods
  def cart_total
    cart_items.sum { |item| item.total_price }
  end

  def cart_item_count
    cart_items.sum(:quantity)
  end

  # Scope for admin users
  scope :admins, -> { where(admin: true) }
end