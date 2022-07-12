class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    if Item.exists?(params[:id])
      render json: ItemSerializer.new(Item.find(params[:id]))
    else
      render json: {error: 'Not Found'}, status: 404
    end
  end

  def create
    new_item = Item.new(item_params)
    if new_item.save
      render json: ItemSerializer.new(new_item), status: 201
    else
      render json: {error: 'Not Found'}, status: 404
    end
  end

  def update
    item = Item.update(params[:id], item_params)
    if item.save
      render json: ItemSerializer.new(item)
    else
      render json: {error: 'Not Found'}, status: 404
    end
  end

  def destroy
    render json: Item.delete(params[:id]), status: 204
  end

  private
    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end
