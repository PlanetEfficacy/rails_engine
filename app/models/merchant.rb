class Merchant < ApplicationRecord
  has_many :invoices
  has_many :customers, through: :invoices

  def self.random
    offset = rand(Merchant.count)
    Merchant.offset(offset).first
  end
end
