class Api::V1::Transactions::InvoiceController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Transaction.find(params[:id]).invoice)
  end
end