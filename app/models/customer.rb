class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.with_pending_invoices(id)
    self.joins(:transactions)
    .where(invoices: {merchant_id: id}, transactions: {result: "failed"})
    .distinct.order(:id)
  end
end
