FactoryBot.define do
  factory :customer do
    first_name { "Scrooge" }
    sequence(:last_name) { |n| "McDuck-#{n}" }
  end
end
