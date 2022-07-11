class Api::V1::MerchantItemsController < ApplicationController

  def index
    id = params[:merchant_id]
    merchant = Merchant.find(id)
    render json: ItemSerializer.new(merchant.items)
  end

end
