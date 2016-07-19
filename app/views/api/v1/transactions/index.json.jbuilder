json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :credit_card_number, :invoice_id, :result
end
