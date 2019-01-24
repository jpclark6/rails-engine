class Api::V1::Merchants::MerchantsItemsController < ApplicationController
  def index
    render json: MerchantsItemsSoldSerializer.new(Merchant.top_items(params[:quantity]))
  end
end