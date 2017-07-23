class ProductsController < ApplicationController
  before_filter :authorize, except: [:index, :show]

  def index
    @products = Product.all
    @order_item = current_order.order_items.new
  end

  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params['show_id'])
    respond_to do |format|
      format.html { redirect_to }
      format.js
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:product_create_success] = "#{@product.name} created successfully"
      redirect_to '/'
    else
      flash[:product_create_fail] = "There was a problem with your product entry."
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    render :edit
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:product_update_success] = "#{@product.name} has been updated by #{current_user.name}"
      redirect_to products_path
    else
      redirect_to products_path
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      flash[:product_destroy_success] = "#{@product.name} has been deleted by #{current_user.name}"
      redirect_to products_path
    else
      redirect_to products_path
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
