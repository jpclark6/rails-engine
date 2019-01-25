class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :invoice_id, :credit_card_number, :result
end
