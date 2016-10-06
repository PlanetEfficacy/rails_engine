class Api::V1::Items::RevenueController < ApplicationController
  # def index
  #   quantity = params["quantity"] || 1
  #   render json: Item.select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) as subtotal")
  #                   .order("subtotal")
  #                   .group("items.id")
  #                   .limit(quantity)
  # end
  def index
  quantity = params["quantity"] || 1
  render json: Item.joins(:invoice_items)
                  .joins(:invoices)
                  .select('SUM(invoice_items.quantity * invoice_items.unit_price) as subtotal')
                  .group(:invoices)
                  .order("subtotal DESC")
                  .limit(quantity)
  end
end
