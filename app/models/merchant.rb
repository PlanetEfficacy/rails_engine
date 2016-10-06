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

  def self.total_revenue_for_date(date)
    {"total_revenue" => float_revenue(Invoice.successful
                    .where(created_at: date)
                    .joins(:invoice_items)
                    .sum("invoice_items.quantity * invoice_items.unit_price"))}
  end

  def customers_with_pending_invoices
    customers.joins("join transactions on transactions.invoice_id = invoices.id")
            .merge(Transaction.pending).distinct



    # select distinct on (customers.id) customers.* from customers inner join invoices
    # on invoices.customer_id = customers.id inner
    # join transactions on transactions.invoice_id = invoices.id where
    # invoices.merchant_id = 17 and transactions.result = 'failed'

    # customers.joins(:invoices).joins(:transactions).where(transactions: )
    # invoices.joins(:transactions).where(transactions: {result: "failed"}).joins(:customer).distinct
    # customers.joins(:transactions).where(transactions: {result: "failed"})
  end

  private

  def self.float_revenue(number)
    "#{'%.2f' % (number/100.0)}"
  end

end
