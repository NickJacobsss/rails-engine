FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence}
    unit_price { Faker::Number.decimal(l_digits: 2)}
    merchant_id { Faker::Number.between(1, 10)}
  end
end
