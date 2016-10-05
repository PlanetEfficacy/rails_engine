class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  has_many :transactions


  def self.random
    offset = rand(Invoice.count)
    Invoice.offset(offset).first
  end
end
