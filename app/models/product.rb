class Product < ApplicationRecord
    has_many_attached :images

    validates :name, presence: true, length: { maximum: 100 }
    validates :price, presence: true, numericality: { greater_than: 0, less_than: 10000 }
    validates :description, presence: true, length: { maximum: 1000 }
    validates :category, presence: true, inclusion: { 
    in: ["coffee collection", "spring has sprung collection", "dessert collection"] 
    }
    validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    scope :available, -> { where('stock_quantity > 0') }
    scope :by_category, ->(category) { where(category: category) if category.present? }
    scope :featured, -> { where(featured: true) }
    scope :search, ->(term) { where("name ILIKE ? OR description ILIKE ?", "%#{term}%", "%#{term}%") if term.present? }

    def formatted_price
    "R#{format('%.2f', price)}"
  end

  def in_stock?
    stock_quantity > 0
  end

  def low_stock?
    stock_quantity <= 5 && stock_quantity > 0
  end

  def primary_image
    images.attached? ? images.first : nil
  end

  # def category_emoji
  #   case category.downcase
  #   when 'vanilla' then '🍦'
  #   when 'fresh' then '🌊'
  #   when 'floral' then '🌸'
  #   when 'spice' then '🌶️'
  #   when 'woodsy' then '🌲'
  #   when 'citrus' then '🍊'
  #   when 'seasonal' then '🍂'
  #   when 'luxury' then '✨'
  #   else '🕯️'
  #   end
  # end

  def stock_status_class
    return 'text-red-600' unless in_stock?
    low_stock? ? 'text-amber-600' : 'text-green-600'
  end
end
