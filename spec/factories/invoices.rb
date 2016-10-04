FactoryGirl.define do
  factory :invoice do
    customer_id { Faker::Number.number(5) }
    merchant_id { Faker::Number.number(5) }
    status "shipped"
  end
end
