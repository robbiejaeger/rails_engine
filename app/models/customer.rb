class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.with_pending_invoices(id)
    self.joins(:transactions)
    .where(invoices: {merchant_id: id}, transactions: {result: "failed"})
    .distinct.order(:id)
  end

  def favorite_merchant
    hash = merchants.joins(invoices: [:transactions])
    .where(transactions: {result: "success"})
    .group(:id).count

    Merchant.find(hash.max_by{ |merchant, count| count }[0])
  end
end
