class Api::V1::SearchController < ApplicationController

  def find_items
    if params[:name].nil? || params[:name].empty?
      render json: {error: 'Not Found'}, status: :bad_request
    else
      items = Item.find_items(params[:name])
      if items.empty?
        render json: { data: [] }, status: 200
      else
        render json: ItemSerializer.new(items)
      end 
    end
  end

  def find_merchant
    if params[:name].nil? || params[:name].empty?
      render json: {error: 'Not Found'}, status: :bad_request
    else
      merchant = Merchant.find_merchant(params[:name])
      if merchant.nil?
        render json: {data: { error: 'No Merchant Found'}}, status: 200
      else
        render json: MerchantSerializer.new(merchant)
      end
    end
  end

end
