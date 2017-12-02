class Api::V1::BillsController < Api::BaseController
  before_action :set_bill, only: [:show]

  def show
    json_response(@bill)
  end

  private

  def set_bill
    @bill = Bill.find(params[:id] || params[:bill_id])
  end
end
