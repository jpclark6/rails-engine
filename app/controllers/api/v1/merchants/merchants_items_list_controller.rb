class Api::V1::Merchants::MerchantsItemsListController < ApplicationController
  def index
    render json: ItemsSerializer.new(Merchant.find(params[:id]).items)
  end
end