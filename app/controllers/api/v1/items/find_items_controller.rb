class Api::V1::Items::FindItemsController < ApplicationController
  def index
    items = Item.find_items_by(params)
    render json: ItemSerializer.new(items) 
  end
  
  def show
    item = Item.find_item_by(params)
    render json: ItemSerializer.new(item)
  end
end