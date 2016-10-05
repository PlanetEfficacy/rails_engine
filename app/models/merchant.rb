class Merchant < ApplicationRecord
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.random
    offset = rand(Merchant.count)
    Merchant.offset(offset).first
  end
end
