# app/controllers/cart_items_controller.rb
class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:create]
  before_action :set_cart_item, only: [:update, :destroy]

  def index
    @cart_items = current_user.cart_items.includes(:product)
    @cart_total = current_user.cart_total
  end

  def create
    @cart_item = current_user.cart_items.find_by(product: @product)
    
    if @cart_item
      @cart_item.quantity += 1
      @cart_item.save
    else
      @cart_item = current_user.cart_items.build(product: @product, quantity: 1)
      @cart_item.save
    end
    
    redirect_back_or_to(@product, notice: 'Item added to cart!')
  end

  def update
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice: 'Cart updated!'
    else
      redirect_to cart_items_path, alert: 'Could not update cart.'
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_items_path, notice: 'Item removed from cart!'
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_cart_item
    @cart_item = current_user.cart_items.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end