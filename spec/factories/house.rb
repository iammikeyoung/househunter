FactoryBot.define do
  factory :house do
    sequence(:name) { |n| "House #{n}" }
    street "101 Arch Street"
    city "Boston"
    state "MA"
    zip_code "02110"
    association :user
  end
end
