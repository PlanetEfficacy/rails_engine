class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.random
    offset = rand(Merchant.count)
    Merchant.offset(offset).first
  end

  def customers_with_pending_invoices
    customers.joins("join transactions on transactions.invoice_id = invoices.id")
            .merge(Transaction.pending).distinct
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

  def self.total_revenue_by_date(date)
    {"total_revenue" => float_revenue(Invoice.successful
      .where(created_at: date)
      .joins(:invoice_items)
      .sum("invoice_items.quantity * invoice_items.unit_price"))}
  end

  def self.most_items_sold(quantity)
    select('merchants.*, SUM(invoice_items.quantity) AS most_items')
      .joins(invoices: [:invoice_items, :transactions])
      .where(transactions: { result: 'success' } )
      .order('most_items DESC')
      .group('merchants.id')
      .limit(quantity)
  end

  def favorite_customer
    customers.select("customers.*, count(invoices.customer_id) as invoice_count")
      .joins(:transactions)
      .merge(Transaction.successful)
      .group(:id)
      .order("invoice_count desc").first
  end

  def self.top_x(number)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .where(transactions: {result: 'success'})
      .order('revenue DESC')
      .group('merchants.id')
      .limit(number)
  end

  private

  def float_revenue(revenue)
    "#{'%.2f' % (revenue/100.0)}"
  end

  def self.float_revenue(number)
    "#{'%.2f' % (number/100.0)}"
  end
end
