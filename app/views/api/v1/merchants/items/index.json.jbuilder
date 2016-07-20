json.array!(@items) do |item|
  json.extract! item, :id, :items
end
