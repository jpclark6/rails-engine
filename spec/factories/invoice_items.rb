FactoryBot.define do
  factory :invoice_item do
    item 
    invoice
    quantity { rand(1..10) }
    unit_price { rand(1..1000) }
  end
end
