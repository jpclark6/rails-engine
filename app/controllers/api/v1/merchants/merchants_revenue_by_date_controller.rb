class Api::V1::Merchants::MerchantsRevenueByDateController < ApplicationController
  def show
    rev = Struct.new(:id, :total_revenue)
    rev_date = rev.new(1, sprintf('%.2f', InvoiceItem.by_date(params[:date]) / 100.0))
    render json: MerchantsRevenueByDateSerializer.new(rev_date)
  end
end