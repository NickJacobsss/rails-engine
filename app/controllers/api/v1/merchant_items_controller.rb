class Api::V1::MerchantItemsController < ApplicationController

  def index
    if Item.exists?(merchant_id: params[:merchant_id])
      merchant = Merchant.find(params[:merchant_id])
      render json: ItemSerializer.new(merchant.items)
    else
      render json: {error: 'Not Found'}, status: 404
    end
  end

  def show
    item = Item.find(params[:id])
    render json: MerchantSerializer.new(item.merchant)
  end

end
