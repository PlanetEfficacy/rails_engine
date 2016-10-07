class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def self.random
    offset = rand(Customer.count)
    Customer.offset(offset).first
  end

  def favorite_merchant
    merchants
    .select("merchants.*, count(invoices.merchant_id) as invoice_count")
    .joins(:transactions).where(transactions: {:result => 'success'}).group(:id).order("invoice_count desc").first
  end
end

