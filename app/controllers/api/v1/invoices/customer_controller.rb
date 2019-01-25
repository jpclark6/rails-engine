class Api::V1::Invoices::CustomerController < ApplicationController
  def show
    render json: CustomerSerializer.new(Invoice.find(params[:id]).customer)
  end
end