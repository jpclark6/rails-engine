class Api::V1::Invoices::FindInvoicesController < ApplicationController
  def index
    invoices = Invoice.find_invoices_by(params)
    render json: InvoiceSerializer.new(invoices) 
  end
  
  def show
    invoice = Invoice.find_invoice_by(params)
    render json: InvoiceSerializer.new(invoice)
  end
end