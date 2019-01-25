FactoryBot.define do
  factory :transaction do
    invoice 
    credit_card_number { "489248932894" }
    credit_card_expiration_date { "2019-01-23" }
    result { 0 }
  end
end
