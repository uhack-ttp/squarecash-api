class Api::V1::ProductsController < Api::BaseController
  before_action :set_product, only: [:show]

  def show
    json_response(@product)
  end

  def create
    @product = Product.create!(product_params)
    json_response(@product, :created)
  end

  private

  def set_product
    @product = Product.find_by_code!(params[:product_code])
  end

  def product_params
    params.require(:product).permit!
  end
end
