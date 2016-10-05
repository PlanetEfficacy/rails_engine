class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  def self.random
    offset = rand(InvoiceItem.count)
    InvoiceItem.offset(offset).first
  end

  def subtotal
    quantity * unit_price
  end
end
