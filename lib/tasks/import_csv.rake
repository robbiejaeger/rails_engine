require 'csv'

namespace :import_csv do
  task :create_customers => :environment do
    csv_text = File.read('data/customers.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Customer.create!(
                      first_name: row["first_name"],
                      last_name: row["last_name"],
                      created_at: row["created_at"],
                      updated_at: row["updated_at"]
                      )
    end
  end

  task :create_merchants => :environment do
    csv_text = File.read('data/merchants.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Merchant.create!(
                      name: row["name"],
                      created_at: row["created_at"],
                      updated_at: row["updated_at"]
                      )
    end
  end
end
