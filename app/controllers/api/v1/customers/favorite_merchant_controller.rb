class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  def show
    render json: MerchantSerializer.new(Customer.find(params[:id]).favorite_merchant)
  end
end