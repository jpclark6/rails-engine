class Api::V1::Transactions::FindTransactionsController < ApplicationController
  def index
    transactions = Transaction.find_transactions_by(params)
    render json: TransactionSerializer.new(transactions) 
  end
  
  def show
    transaction = Transaction.find_transaction_by(params)
    render json: TransactionSerializer.new(transaction)
  end
end