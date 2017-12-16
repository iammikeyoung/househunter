FactoryBot.define do
  factory :user do
    first_name "Joe"
    last_name "Shmoe"
    sequence(:email) { |n| "joe#{n}@example.com" }
    password "supersecret"
  end
end
