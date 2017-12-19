FactoryBot.define do
  factory :note do
    room "Room Or House Feature"
    pros "Things you like"
    cons "Things you do not like"
    association :user
    association :house
  end
end
