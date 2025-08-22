class Setting < ApplicationRecord
  has_one_attached :logo
  
  validates :key, presence: true, uniqueness: true
  
  # Class method to get or create the site logo setting
  def self.site_logo
    find_or_create_by(key: 'site_logo')
  end
  
  # Check if logo is attached
  def logo_attached?
    logo.attached?
  end
end