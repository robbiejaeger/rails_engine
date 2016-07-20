FactoryGirl.define do
  factory :merchant do
    name { generate(:merchant_name) }
  end

  sequence :merchant_name do |n|
    "Merchant-#{n}"
  end

  factory :item do
    name { generate(:item_name) }
    description { generate(:item_description) }
    unit_price 15050
    merchant
  end
  # Item Sequences
  sequence :item_name do |n|
    "Item-#{n}"
  end

  sequence :item_description do |n|
    "Item Description-#{n}"
  end

  factory :customer do
    first_name { generate(:customer_first_name) }
    last_name { generate(:customer_last_name) }
  end
  #customer Sequences
  sequence :customer_first_name do |n|
    "John-#{n}"
  end

  sequence :customer_last_name do |n|
    "Doe-#{n}"
  end

  factory :invoice do
    customer
    merchant
    status "shipped"
  end

  factory :invoice_item do
    item
    invoice
    quantity 5
    unit_price
  end

  factory :transaction do
    invoice
    credit_card_number "4587-1233-8756-4583"
    credit_card_expiration_date "2017-03-27 14:54:09 UTC"
    result "success"
  end
end
