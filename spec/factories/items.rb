FactoryBot.define do
  factory :item do
    merchant
    sequence(:name) { |n| "Trampoline-#{n}" }
    sequence(:description) { |n| "To jump #{n} times" }
    unit_price { rand(1..5000) }
  end
end
