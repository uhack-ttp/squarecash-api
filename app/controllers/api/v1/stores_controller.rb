class Api::V1::StoresController < Api::BaseController
  before_action :set_store, only: [:show, :products, :transactions]

  def index
    @stores = Store.all
    json_response(@stores)
  end

  def show
    json_response(@store)
  end

  def products
    @products = @store.products
    json_response(@products)
  end

  def transactions
    @transactions = @store.transactions
    json_response(@transactions)
  end

  private

  def set_store
    @store = Store.find(params[:id] || params[:store_id])
  end
end
