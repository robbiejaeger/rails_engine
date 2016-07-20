json.array!(@customers) do |customer|
  json.extract! customer, :id, :first_name, :last_name
end
