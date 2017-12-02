class Api::V1::ProductsController < Api::BaseController
  before_action :set_product, only: [:show]

  def show
    json_response(@product)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
