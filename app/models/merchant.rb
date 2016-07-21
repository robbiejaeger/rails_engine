class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  # def customers_and_successful_transactions
  #   result = {}
  #   customer_array = customers.distinct
  #   customer_array.each do |customer|
  #     result[customer] = customer.transactions.where(result: 'success', ).count
  #   end
  #   return result
  # end

  def favorite_customer_id
    hash = customers.joins(:transactions).where(transactions: {result: 'success'}).group(:id).count
    result = hash.max_by{ |customer, count| count }
    return result[0]
  end
end
