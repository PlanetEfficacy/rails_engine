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
    joins(:invoices)
    .merge(Invoice.successful)
    .group(:id)
    .order("sum(invoice_items.quantity) DESC")
    .first(number)
  end

  def best_day
    # Item.find(1099).invoices
    # .select("invoices.*, SUM(invoice_items.quantity)
    # as item_quantity").joins(:invoice_items)
    # .order("item_quantity DESC")
    # .group("invoices.id").first.created_at

    # get the item
    # get invoice
    # get its invoice items
    # get the quantity


    invoices.select("invoices.*, SUM(invoice_items.quantity) as quantity")
      .joins(:invoice_items)
      .order("quantity DESC, invoices.created_at DESC")
      .group("invoices.id").first.created_at
  end
end
