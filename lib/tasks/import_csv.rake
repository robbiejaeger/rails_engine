require 'csv'

namespace :import_csv do
  task :create_customers => :environment do
    csv_text = File.read('data/customers.csv')
    csv = CSV.parse(csv_text, :headers => true)
    puts "Parsing customers"
    csv.each do |row|
      Customer.create!(
                      first_name: row["first_name"],
                      last_name: row["last_name"],
                      created_at: row["created_at"],
                      updated_at: row["updated_at"]
                      )
    end
    puts "Created customers"
  end

  task :create_merchants => :environment do
    csv_text = File.read('data/merchants.csv')
    csv = CSV.parse(csv_text, :headers => true)
    puts "Parsing merchants"
    csv.each do |row|
      Merchant.create!(
                      name: row["name"],
                      created_at: row["created_at"],
                      updated_at: row["updated_at"]
                      )
    end
    puts "Created merchants"
  end

  task :create_invoice_items => :environment do
    csv_text = File.read('data/invoice_items.csv')
    csv = CSV.parse(csv_text, :headers => true)
    puts "Parsing invoice items"
    csv.each do |row|
      InvoiceItem.create!(
                      item_id: row['item_id'],
                      invoice_id: row['invoice_id'],
                      quantity: row['quantity'],
                      unit_price: row['unit_price'],
                      created_at: row["created_at"],
                      updated_at: row["updated_at"]
      )
    end
    puts "Created invoice items"
  end

  task :create_items => :environment do
    csv_text = File.read('data/items.csv')
    csv = CSV.parse(csv_text, :headers => true)
    puts "Parsing items"
    csv.each do |row|
      Item.create!(
                  name: row['name'],
                  description: row['description'],
                  unit_price: row['unit_price'],
                  merchant_id: row['merchant_id'],
                  created_at: row["created_at"],
                  updated_at: row["updated_at"]
      )
    end
    puts "Created items"
  end

  task :create_invoices => :environment do
    csv_text = File.read('data/invoices.csv')
    csv = CSV.parse(csv_text, :headers => true)
    puts "Parsing invoices"
    csv.each do |row|
      Invoice.create!(
                  customer_id: row['customer_id'],
                  merchant_id: row['merchant_id'],
                  status: row['status'],
                  created_at: row["created_at"],
                  updated_at: row["updated_at"]
      )
    end
    puts "Created invoices"
  end

  task :create_transactions => :environment do
    csv_text = File.read('data/transactions.csv')
    csv = CSV.parse(csv_text, :headers => true)
    puts "Parsing transactions"
    csv.each do |row|
      Transaction.create!(
                  invoice_id: row['invoice_id'],
                  credit_card_number: row['credit_card_number'],
                  credit_card_expiration_date: row['credit_card_expiration_date'],
                  result: row['result'],
                  created_at: row["created_at"],
                  updated_at: row["updated_at"]
      )
    end
    puts "Created transactions"
  end

  task :create_all => :environment do
    Rake::Task["import_csv:create_customers"].invoke
    Rake::Task["import_csv:create_merchants"].invoke
    Rake::Task["import_csv:create_items"].invoke
    Rake::Task["import_csv:create_invoices"].invoke
    Rake::Task["import_csv:create_transactions"].invoke
    Rake::Task["import_csv:create_invoice_items"].invoke
  end
end
