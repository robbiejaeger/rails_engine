json.array!(@items) do |item|
  json.extract! item, :id, :name, :description, :unit_price, :merchant_id
end