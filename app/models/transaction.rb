class Transaction < ApplicationRecord
  belongs_to :invoice
  
  def self.random 
    offset = rand(Transaction.count)
    Transaction.offset(offset).first
  end
end
