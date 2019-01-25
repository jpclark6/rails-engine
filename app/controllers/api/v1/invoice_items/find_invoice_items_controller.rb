class Api::V1::InvoiceItems::FindInvoiceItemsController < ApplicationController
  def show
    invoice_item = InvoiceItem.find_invoice_item_by(params)
    render json: InvoiceItemSerializer.new(invoice_item)
  end
end