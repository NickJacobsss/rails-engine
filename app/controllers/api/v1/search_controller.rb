class Api::V1::SearchController < ApplicationController

  def find_items
    items = Item.find_items(params[:name])
    if items.nil?
      render json: { data: [] }, status: 200
    else
      render json: ItemSerializer.new(items)
    end
  end

  def find_merchant
    merchant = Merchant.find_merchant(params[:name])
    if merchant.nil?
      render json: {data: { error: 'No Merchant Found'}}, status: 200
    else
      render json: MerchantSerializer.new(merchant)
    end
  end

end
