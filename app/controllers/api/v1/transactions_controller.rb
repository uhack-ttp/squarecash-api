class Api::V1::TransactionsController < Api::BaseController
  before_action :set_transaction, only: [:show, :update, :destroy]

  def index
    @transactions = Transaction.all
    json_response(@transactions)
  end

  def show
    json_response(@transaction)
  end

  def create
    @transaction = Transaction.create!(transaction_params)
    json_response(@transaction, :created)
  end

  def update
    @transaction.update!(transaction_params)
    json_response(@transaction, :updated)
  end

  def destroy
    @transaction.destroy
    head :no_content
  end

  def checkout
    @transaction = Transaction.find_by_code!(params[:transaction_code])
    @transaction.finish!
    response = @transaction.errors.present? ?
                 @transaction.errors.as_json : @transaction
    json_response(response)
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id] || params[:transaction_id])
  end

  def transaction_params
    params.require(:transaction).permit!
  end
end
