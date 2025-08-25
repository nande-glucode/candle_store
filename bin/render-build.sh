set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails tailwindcss:build  # Important for Tailwind
bundle exec rails db:migrate
bundle exec rails db:seed

echo "🚀 Starting build process..."

# Install dependencies
echo "📦 Installing Ruby gems..."
bundle install

# Precompile assets
echo "🎨 Precompiling assets..."
bundle exec rails assets:precompile

# Build Tailwind CSS
echo "💄 Building Tailwind CSS..."
bundle exec rails tailwindcss:build

# Clean old assets
echo "🧹 Cleaning old assets..."
bundle exec rails assets:clean

# Run database migrations
echo "🗄️ Running database migrations..."
bundle exec rails db:migrate

# Seed database (optional - remove if you don't want to seed in production)
echo "🌱 Seeding database..."
bundle exec rails db:seed

echo "✅ Build completed successfully!"