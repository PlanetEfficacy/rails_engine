class Api::V1::Items::RevenueController < ApplicationController
  def index
    quantity = params["quantity"] || 1
    render json: Item.joins(:invoice_items)
                    .joins(:invoices)
                    .select('SUM(invoice_items.quantity * invoice_items.unit_price) as subtotal')
                    .group(:invoices)
                    .order(:subtotal)
                    .limit(quantity)
  end
end
