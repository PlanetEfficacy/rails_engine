class Merchant < ApplicationRecord
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.random
    offset = rand(Merchant.count)
    Merchant.offset(offset).first
  end

  def customers_with_pending_invoices
    # customers.joins(:invoices).joins(:transactions).where(transactions: )
    # invoices.joins(:transactions).where(transactions: {result: "failed"}).joins(:customer).distinct
    # customers.joins(:transactions).where(transactions: {result: "failed"})
  end
end
