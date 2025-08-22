# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb
Product.delete_all
User.delete_all

admin = User.create!(
  email: 'admin@candlestore.com',
  password: 'password123',
  password_confirmation: 'password123',
  first_name: 'Admin',
  last_name: 'User',
  admin: true
)

puts "✅ Created admin user: #{admin.email}"

user = User.create!(
  email: 'customer@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  first_name: 'Jane',
  last_name: 'Doe'
)

puts "✅ Created test user: #{user.email}"

products_data = [
  {
    name: 'Iced Vanilla Latte',
    description: 'A warm and comforting iced vanilla latte candle with hints of vanilla and espresso. Hand-poured with natural soy wax and cotton wick for a clean, long-lasting burn.',
    price: 250.00,
    category: 'coffee collection',
    stock_quantity: 15,
  },
  {
    name: 'Iced Caramel Macchiatto',
    description: 'A warm and comforting iced vanilla latte candle with hints of caramel and espresso. Hand-poured with natural soy wax and cotton wick for a clean, long-lasting burn.',
    price: 250.00,
    category: 'coffee collection',
    stock_quantity: 18
  },
  {
    name: 'Iced Mocha',
    description: 'A warm and comforting iced vanilla latte candle with hints of chocolate and espresso. Hand-poured with natural soy wax and cotton wick for a clean, long-lasting burn.',
    price: 250.00,
    category: 'coffee collection',
    stock_quantity: 8,
    featured: true
  },
  {
    name: 'Lavender Fields',
    description: 'Pure French lavender essential oil creates a calming sanctuary in your home. Hand-topped with dried lavender flowers for an authentic botanical experience. Perfect for evening relaxation and restful sleep.',
    price: 285.00,
    category: 'spring has sprung collection',
    stock_quantity: 12
  },
  {
    name: 'Rose Garden Bliss',
    description: 'Luxurious Bulgarian rose scent captures the essence of a blooming garden. Adorned with delicate pink rose petals that release additional fragrance as the candle burns. A romantic indulgence for special moments.',
    price: 295.00,
    category: 'spring has sprung collection',
    stock_quantity: 8,
  },
  {
    name: 'Citrus Bloom',
    description: 'Bright lemon zest balanced with creamy vanilla creates an uplifting yet sophisticated aroma. Crowned with sunny yellow flower petals that add natural beauty and gentle citrus notes throughout the burn.',
    price: 275.00,
    category: 'spring has sprung collection',
    stock_quantity: 15,
    featured: true
  },
  {
    name: 'Mint Macaron',
    description: 'Fresh peppermint essential oil blended with sweet vanilla creates the perfect balance of refreshing and comforting. Designed to resemble a delicate green macaron, this candle brings French patisserie elegance to your space.',
    price: 320.00,
    category: 'dessert collection',
    stock_quantity: 10
  },
  {
    name: 'Rose Petal Cake',
    description: 'Decadent rose and vanilla blend reminiscent of wedding cake and celebration. Crafted in soft pink with elegant styling, this candle transforms any room into a sophisticated dessert lounge.',
    price: 325.00,
    category: 'dessert collection',
    stock_quantity: 7,
  },
  {
    name: 'Valentine\'s Delight',
    description: 'Romantic rose and smooth vanilla create the ultimate love-inspired fragrance. Designed in passionate red with charming heart details, perfect for intimate dinners and romantic evenings.',
    price: 330.00,
    category: 'dessert collection',
    stock_quantity: 6,
    featured: true
  }
]

products_data.each do |product_attrs|
  Product.create!(product_attrs)
end

puts "✨ Created #{Product.count} products"
puts "📊 Featured products: #{Product.featured.count}"
puts "📦 Products in stock: #{Product.available.count}"
puts "🏷️ Categories: #{Product.distinct.pluck(:category).join(', ')}"
puts "🔐 Admin login: admin@candlestore.com / password123"
puts "👤 Test login: customer@example.com / password123"