class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.revenue(merchant_id)
    revenue_cents = self.joins(invoices: [:transactions, :invoice_items])
    .where(transactions: {result: "success"})
    .where("merchants.id = ?", merchant_id)
    .sum("invoice_items.unit_price * invoice_items.quantity")

    (revenue_cents.to_f / 100).to_s
  end

  def self.revenue_for_date(merchant_id, date)
    revenue_cents = self.joins(invoices: [:transactions, :invoice_items])
    .where(transactions: {result: "success"})
    .where("merchants.id = ?", merchant_id)
    .where(invoices: {created_at: date})
    .sum("invoice_items.unit_price * invoice_items.quantity")

    (revenue_cents.to_f / 100).to_s
  end

  def self.most_items_sold(quantity)
    self.joins(invoices: [:transactions, :invoice_items])
    .where(transactions: {result: "success"})
    .group(:id).order("sum(invoice_items.quantity) DESC")
    .limit(quantity.to_i)
  end
end
