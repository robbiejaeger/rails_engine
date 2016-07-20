json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :invoice_id, :credit_card_number, :result
end
