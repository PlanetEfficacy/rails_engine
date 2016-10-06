class Transaction < ApplicationRecord
  belongs_to :invoice
  # scope :successful, -> {where('result = ?', 'success')}
  # scope :pending, -> {where('result = ?', 'failed')}
  # scope :pending, where(:result => 'failed')
  # scope :pending, -> (color) { where(:color => color) }
  def self.pending
    where(:result => 'failed')
  end

  def self.random
    offset = rand(Transaction.count)
    Transaction.offset(offset).first
  end
end
