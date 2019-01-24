class Api::V1::Merchants::MerchantsRevenueController < ApplicationController
  def index
    render json: MerchantsRevenueSerializer.new(Merchant.top_revenue(params[:quantity]))
  end
end