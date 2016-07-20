json.array!(@invoice_items) do |invoice_item|
  json.extract! invoice_item, :id, :item_id, :invoice_id, :quantity, :unit_price
end
