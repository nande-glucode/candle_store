# app/controllers/checkout_controller.rb
class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_cart_not_empty
  
  def new
    @order = current_user.orders.build
    @cart_items = current_user.cart_items.includes(:product)
    @cart_total = current_user.cart_total
  end
  
  def create
    @order = current_user.orders.build(order_params)
    @order.total = current_user.cart_total
    @order.status = 'pending'
    
    if @order.save
      current_user.cart_items.each do |cart_item|
        @order.order_items.create(
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: cart_item.product.price
        )
      end
      
      current_user.cart_items.destroy_all
      
      redirect_to checkout_confirmation_path(@order)
    else
      @cart_items = current_user.cart_items.includes(:product)
      @cart_total = current_user.cart_total
      render :new
    end
  end
  
  def confirmation
    @order = current_user.orders.find(params[:id])
  end
  
  private
  
  def order_params
    params.require(:order).permit(:first_name, :last_name, :email, :phone, :address, :city, :postal_code, :country)
  end
  
  def ensure_cart_not_empty
    if current_user.cart_items.empty?
      redirect_to cart_items_path, alert: 'Your cart is empty!'
    end
  end
end