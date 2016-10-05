class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items

  def self.random
    offset = rand(Invoice.count)
    Invoice.offset(offset).first
  end

  def revenue
    invoice_items.sum("quantity * unit_price")
  end
end
