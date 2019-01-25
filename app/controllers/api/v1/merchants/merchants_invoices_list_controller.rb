class Api::V1::Merchants::MerchantsInvoicesListController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Merchant.find(params[:id]).invoices)
  end
end