class Merchant < ApplicationRecord
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :items


  def self.random
    offset = rand(Merchant.count)
    Merchant.offset(offset).first
  end

  def customers_with_pending_invoices
    customers.joins(:transactions).where(transactions: {result: "failed"})
  end

  def total_revenue
    {"revenue" => float_revenue(invoices
    .joins(:transactions)
    .where(transactions: {result: "success"})
    .joins(:invoice_items)
    .sum("invoice_items.quantity * invoice_items.unit_price"))}
  end
  
  def total_revenue_by_date(date)
    {"revenue" => float_revenue(invoices
    .where(invoices: {created_at: date})
    .joins(:transactions)
    .where(transactions: {result: "success"})
    .joins(:invoice_items)
    .sum("invoice_items.quantity * invoice_items.unit_price"))}
  end
  
  def float_revenue(revenue)
    "#{'%.2f' % (revenue/100.0)}"
  end
end
