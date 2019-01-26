class Api::V1::InvoiceItems::FindInvoiceItemsController < ApplicationController
  def index
    invoice_items = InvoiceItem.find_invoice_items_by(params)
    render json: InvoiceItemSerializer.new(invoice_items) 
  end
  
  def show
    invoice_item = InvoiceItem.find_invoice_item_by(params)
    render json: InvoiceItemSerializer.new(invoice_item)
  end
end