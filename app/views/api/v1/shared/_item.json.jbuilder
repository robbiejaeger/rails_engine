json.extract! item, :id, :name, :description, :merchant_id
json.unit_price number_with_precision(item.unit_price.to_f/100, precision: 2)
