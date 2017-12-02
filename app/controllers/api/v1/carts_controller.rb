class Api::V1::CartsController < Api::BaseController
  before_action :set_cart, only: [:update, :destroy, :items,
                                  :update_item, :add_item, :delete_item]
  before_action :set_cart_by_code, only: [:show]
  before_action :set_product, only: [:update_item, :add_item, :delete_item]
  # before_action :check_if_current_store, only: [:add_item]
  # before_action :check_if_item_is_already_added, only: [:add_item]
  before_action :check_if_product_has_enough_stocks, only: [:update_item]

  def show
    json_response(@cart)
  end

  def create
    @user = Customer.find(cart_params[:customer_id])
    @cart = Cart.find_or_create_active_cart(@user, cart_params)
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
    json_response(cart_items, :ok)
  end

  def update_item
    item = Item.find_by(product: @product)
    item.update_attributes(cart_params)
    json_response(cart_items, :ok)
  end

  def add_item
    @cart.update_attribute(:store, @product.store) if @cart.store.blank?
    item = Item.new(cart_params)
    item.cart = @cart
    item.product = @product
    @cart.items << item

    json_response(cart_items, :ok)
  end

  def delete_item
    item = Item.find_by(product: @product)
    @cart.items.delete(item)

    json_response(cart_items, :ok)
  end

  private

  def set_cart_by_code
    @cart = Cart.find_by_code!(params[:transaction_code])
  end

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
      json_response({message: 'not enough stocks'}, :unprocessable_entity)
    end
  end

  # def check_if_current_store
  #   return true unless @cart.store == @product.store || @cart.store.blank?
  #   json_response({message: 'product not in the same store'}, :unprocessable_entity)
  # end

  # def check_if_item_is_already_added
  #   @product = Product.find_by_code(params[:product_code])
  #   @cart = Cart.find(params[:id] || params[:cart_id])
  #   return true unless @cart.items.map(&:product).include?(@product)
  #   json_response({message: 'item is already added'}, :unprocessable_entity)
  # end

  def cart_params
    params.require(:cart).permit!
  end

  def cart_items
    items = @cart.items.each.map do |i|
      {item: i, product: i.product}
    end
    { cart: @cart, items: items }
  end
end
