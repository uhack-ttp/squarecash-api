class Api::V1::CartsController < Api::BaseController
  before_action :set_cart, only: [:show, :update, :destroy]

  def show
    json_response(@cart)
  end

  def create
    @cart = Cart.create!(cart_params)
    json_response(@cart, :created)
  end

  def update
    @cart.update!(cart_params)
    json_response(@cart, :updated)
  end

  def destroy
    @cart.destroy
    head :no_content
  end

  def items
    @cart = Cart.find(params[:cart_id])
    json_response({cart: @cart, items: @cart.items})
  end

  def update_item
    @cart = Cart.find(params[:cart_id])
    product = Product.find_by_code(params[:product_code])
    item = Item.find_by(product: product)
    item.update_attributes(cart_params)
    json_response({cart: @cart, items: @cart.items}, :updated)
  end

  def add_item
    @cart = Cart.find(params[:cart_id])
    product = Product.find_by_code(params[:product_code])
    item = Item.new(cart_params)
    item.cart = @cart
    item.product = product
    @cart.items << item

    json_response({cart: @cart, items: @cart.items}, :updated)
  end

  def delete_item
    @cart = Cart.find(params[:cart_id])
    product = Product.find_by_code(params[:product_code])
    item = Item.find_by(product: product)
    @cart.items.delete(item)

    json_response({cart: @cart, items: @cart.items}, :updated)
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

  def cart_params
    params.require(:cart).permit!
  end
end
