FactoryGirl.define do
  factory :invoice_item do
    item_id { Faker::Number.number(5) }
    invoice_id { Faker::Number.number(5) }
    quantity { Faker::Number.number(1) }
    unit_price { Faker::Number.number(5) }
  end
end
