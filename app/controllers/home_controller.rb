class HomeController < ApplicationController
  def index
    @featured_products = Product.featured.available.limit(6)
    @categories_with_counts = Product.available.group(:category).count
    @total_products = Product.available.count
  end
end
