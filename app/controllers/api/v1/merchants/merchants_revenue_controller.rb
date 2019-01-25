class Api::V1::Merchants::MerchantsRevenueController < ApplicationController
  def index
    render json: MerchantsRevenueSerializer.new(Merchant.top_revenue(params[:quantity]))
  end

  def show
    rev = Struct.new(:id, :revenue)
    revenue = rev.new(1, sprintf('%.2f', Merchant.find(params[:id]).total_revenue(params) / 100.0))
    render json: MerchantRevenueSerializer.new(revenue)
  end
end