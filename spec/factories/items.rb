FactoryGirl.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph(2) }
    unit_price { Faker::Number.number(5) }
    merchant
  end
end
