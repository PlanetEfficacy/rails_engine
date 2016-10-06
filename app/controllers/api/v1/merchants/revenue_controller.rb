class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    render json: Merchant.find(params[:id])
                         .invoices
                         .joins(:transactions)
                         .where(transactions: {result: "success"})
                         .joins(:invoice_items)
                         .sum("invoice_items.quantity * invoice_items.unit_price")
  end
end