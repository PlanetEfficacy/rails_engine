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
end
