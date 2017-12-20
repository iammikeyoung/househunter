FactoryBot.define do
  factory :note do
    sequence(:room) { |n| "Room #{n}" }
    pros "Things you like"
    cons "Things you do not like"
    association :user
    association :house
  end
end
