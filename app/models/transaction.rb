class Transaction < ApplicationRecord
  belongs_to :invoice
  # scope :successful, -> {where('result = ?', 'success')}
  # scope :pending, -> {where('result = ?', 'failed')}


  def self.random
    offset = rand(Transaction.count)
    Transaction.offset(offset).first
  end
end
