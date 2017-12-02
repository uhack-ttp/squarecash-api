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
    json_response({products: @products,
                   total_sales: @store.total_sales,
                   total_quantity: @store.total_quantity_sold
                  }, :ok)
  end

  def transactions
    @transactions = @store.transactions
    json_response({transactions: transaction_customers,
                   total_sales: @store.total_sales,
                   total_quantity: @store.total_quantity_sold
                  }, :ok)
  end

  private

  def transaction_customers
    @transactions.map do |t|
      t.attributes.merge({ updated_at: t.updated_at,
                           customer_name: t.customer.full_name})
    end
  end

  def set_store
    @store = Store.find(params[:id] || params[:store_id])
  end
end
