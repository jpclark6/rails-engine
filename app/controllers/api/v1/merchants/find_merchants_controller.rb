class Api::V1::Merchants::FindMerchantsController < ApplicationController
  def index
    merchants = Merchant.find_merchants_by(params)
    render json: MerchantSerializer.new(merchants) 
  end
  
  def show
    merchant = Merchant.find_merchant_by(params)
    render json: MerchantSerializer.new(merchant)
  end
end