FactoryGirl.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph(2) }
    unit_price { Faker::Number.number(5) }
    created_at { Faker::Date.between(100.days.ago, 50.days.ago) }
    updated_at { Faker::Date.between(50.days.ago, Date.today) }
    merchant
  end
end
