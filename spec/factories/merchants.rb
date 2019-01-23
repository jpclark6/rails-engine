FactoryBot.define do
  factory :merchant do
    sequence(:name) { |n| "Bugs Bunny-#{n}" }
  end
end
