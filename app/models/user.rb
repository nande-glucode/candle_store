# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

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

  # Scope for admin users
  scope :admins, -> { where(admin: true) }
end