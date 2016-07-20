json.extract! @invoice_item, :id, :item_id, :invoice_id, :quantity
json.unit_price number_with_precision(@invoice_item.unit_price.to_f/100, precision: 2)
