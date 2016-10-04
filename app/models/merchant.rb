class Merchant < ApplicationRecord
  def self.random 
    offset = rand(Merchant.count)
    Merchant.offset(offset).first
  end
end
