FactoryBot.define do
  factory :customer do
    sequence(:first_name) { |n| "Scrooge-#{n}" } 
    sequence(:last_name) { |n| "McDuck-#{n}" }
  end
end
