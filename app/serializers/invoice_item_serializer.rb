class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :item_id, :invoice_id, :quantity, :unit_price

  attribute :unit_price do |ii|
    sprintf('%.2f', (ii.unit_price/100.0))
  end
end
