class Api::V1::CartsController < Api::BaseController
  before_action :set_cart, only: [:show, :update, :destroy, :items,
                                  :update_item, :add_item, :delete_item]
  before_action :set_product, only: [:update_item, :add_item, :delete_item]
  before_action :check_if_current_store, only: [:add_item]
  before_action :check_if_product_has_enough_stocks, only: [:update_item]

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
    json_response({cart: @cart, items: @cart.items})
  end

  def update_item
    item = Item.find_by(product: @product)
    item.update_attributes(cart_params)
    json_response({cart: @cart, items: @cart.items}, :updated)
  end

  def add_item
    @cart.update_attribute(:store, @product.store) if @cart.store.blank?
    item = Item.new(cart_params)
    item.cart = @cart
    item.product = @product
    @cart.items << item

    json_response({cart: @cart, items: @cart.items}, :updated)
  end

  def delete_item
    item = Item.find_by(product: @product)
    @cart.items.delete(item)

    json_response({cart: @cart, items: @cart.items}, :updated)
  end

  private

  def set_product
    @product = Product.find_by_code(params[:product_code])
  end

  def set_cart
    @cart = Cart.find(params[:id] || params[:cart_id])
  end

  def check_if_product_has_enough_stocks
    return false if cart_params[:quantity].blank?
    @product = Product.find_by_code!(params[:product_code])
    item_qty = cart_params[:quantity]

    if @product.quantity >= item_qty.to_i
      true
    else
      json_response({message: 'not enough stocks'})
    end
  end

  def check_if_current_store
    unless @cart.store == @product.store || @cart.store.blank?
      json_response({message: 'product not in the same store'})
    end
  end

  def cart_params
    params.require(:cart).permit!
  end
end
