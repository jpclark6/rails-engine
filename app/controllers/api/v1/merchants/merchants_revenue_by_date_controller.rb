class Api::V1::Merchants::MerchantsRevenueByDateController < ApplicationController
  def show
    render json: MerchantsRevenueByDateSerializer.new(InvoiceItem.by_date(params[:date]))
  end
end