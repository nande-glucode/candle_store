class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin
  before_action :set_product, only: [:show, :edit, :update, :destroy, :manage_images, :attach_images, :remove_image]

  def index
    @products = Product.all.order(:name)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    
    if @product.save
      redirect_to admin_product_path(@product), notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: 'Product was successfully deleted.'
  end

  def manage_images
    # This action renders the image management page
  end

  def attach_images
    if params[:product][:images].present?
      params[:product][:images].each do |image|
        @product.images.attach(image)
      end
      redirect_to manage_images_admin_product_path(@product), notice: 'Images uploaded successfully.'
    else
      redirect_to manage_images_admin_product_path(@product), alert: 'Please select images to upload.'
    end
  end

  def remove_image
    image = @product.images.find(params[:image_id])
    image.purge
    redirect_to manage_images_admin_product_path(@product), notice: 'Image deleted successfully.'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :category, :stock_quantity, :featured, images: [])
  end

  def ensure_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user&.admin?
  end
end