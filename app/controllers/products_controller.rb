# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  
  def index
    @products = Product.includes(images_attachments: :blob)
    
    # Filtering
    @products = @products.by_category(params[:category]) if params[:category].present?
    @products = @products.search(params[:search]) if params[:search].present?
    @products = @products.available if params[:in_stock] == 'true'
    
    # Sorting
    case params[:sort]
    when 'price_low'
      @products = @products.order(:price)
    when 'price_high'
      @products = @products.order(price: :desc)
    when 'name'
      @products = @products.order(:name)
    else
      @products = @products.order(featured: :desc, created_at: :desc)
    end
    
    @current_category = params[:category]
    @search_term = params[:search]
  end
  
  def show
    @related_products = Product.where(category: @product.category)
                               .where.not(id: @product.id)
                               .available
                               .limit(4)
  end
  
  private
  
  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path, alert: 'Product not found.'
  end
end