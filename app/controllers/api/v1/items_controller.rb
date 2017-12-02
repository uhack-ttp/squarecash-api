class Api::V1::ItemsController < Api::BaseController
  before_action :set_item, only: [:show, :update, :destroy]

  def show
    json_response(@item)
  end

  def create
    @item = Item.create!(item_params)
    json_response(@item, :created)
  end

  def update
    @item.update!(item_params)
    json_response(@item, :updated)
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit!
  end
end
