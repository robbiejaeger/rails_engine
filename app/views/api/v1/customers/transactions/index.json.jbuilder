json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result
  json.url transaction_url(transaction, format: :json)
end
