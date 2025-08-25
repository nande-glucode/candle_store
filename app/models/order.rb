class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :first_name, :last_name, :email, :address, :city, presence: true

  enum :status, { pending: 0, confirmed: 1, shipped: 2, delivered: 3 }, prefix: :order

  def formatted_total
    return "R0.00" if total.nil?
    "R#{sprintf('%.2f' , total)}"
  end
end
