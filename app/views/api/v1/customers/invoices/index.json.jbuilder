json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :customer_id, :merchant_id, :status
end
