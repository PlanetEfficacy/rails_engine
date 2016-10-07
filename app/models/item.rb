class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.random
    offset = rand(Item.count)
    Item.offset(offset).first
  end

  def self.top_x_revenue(number)
    select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .where(transactions: {result: 'success'})
      .order('revenue DESC')
      .group('items.id')
      .limit(number)
  end
  
  def self.top_x_sold(number)
    select("items.*, SUM(invoice_items.quantity) as sold")
      .joins(invoices: [:invoice_items, :transactions])
      .where(transactions: {result: 'success'})
      .order('sold DESC')
      .group('items.id')
      .limit(number)
  end
end
