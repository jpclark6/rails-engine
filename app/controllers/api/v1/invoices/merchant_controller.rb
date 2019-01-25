class Api::V1::Invoices::MerchantController < ApplicationController
  def show
    render json: MerchantSerializer.new(Invoice.find(params[:id]).merchant)
  end
end