class Merchant < ApplicationRecord
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :items

  def self.random
    offset = rand(Merchant.count)
    Merchant.offset(offset).first
  end
end
