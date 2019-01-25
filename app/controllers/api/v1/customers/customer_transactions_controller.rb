class Api::V1::Customers::CustomerTransactionsController < ApplicationController
  def index
    render json: TransactionSerializer.new(Customer.find(params[:id]).all_transactions)
  end
end