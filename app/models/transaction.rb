class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number, :result
  belongs_to :invoice

  enum result: [:success, :failed]

  def self.find_transaction_by(params)
    if params.keys.index("id")
      transaction = Transaction.find_by_id(params["id"])
    elsif params.keys.index("invoice_id")
      transaction = Transaction.where("invoice_id = ?", params["invoice_id"]).first
    elsif params.keys.index("credit_card_number")
      transaction = Transaction.where("credit_card_number = ?", params["credit_card_number"]).first
    elsif params.keys.index("credit_card_expiration_date")
      transaction = Transaction.where("credit_card_expiration_date = ?", params["credit_card_expiration_date"]).first
    elsif params.keys.index("result")
      transaction = Transaction.where("result = ?", result_enum[params["result"]]).first
    elsif params.keys.index("updated_at")
      transaction = Transaction.where(updated_at: params["updated_at"]).first
    elsif params.keys.index("created_at")
      transaction = Transaction.where(created_at: params["created_at"]).first
    end
    transaction
  end

  def self.find_transactions_by(params)
    if params.keys.index("id")
      transactions = [Transaction.find_by_id(params["id"])]
    elsif params.keys.index("invoice_id")
      transactions = Transaction.where("invoice_id = ?", params["invoice_id"])
    elsif params.keys.index("credit_card_number")
      transactions = Transaction.where("credit_card_number = ?", params["credit_card_number"])
    elsif params.keys.index("credit_card_expiration_date")
      transactions = Transaction.where("credit_card_expiration_date = ?", params["credit_card_expiration_date"])
    elsif params.keys.index("result")
      transactions = Transaction.where("result = ?", result_enum[params["result"]])
    elsif params.keys.index("updated_at")
      transactions = Transaction.where(updated_at: params["updated_at"])
    elsif params.keys.index("created_at")
      transactions = Transaction.where(created_at: params["created_at"])
    end
    transactions
  end

  def self.result_enum
    {"success" => 0, "failed" => 1}
  end
 
end
