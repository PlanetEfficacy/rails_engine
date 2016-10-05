class Api::V1::Merchants::AllRevenueController < ApplicationController
  def show
    date = params["date"]
    render json: Invoice.joins(:invoice_items)
                        .where(invoice_items: {created_at: date})
                        .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def index
    quantity = params["quantity"]
    # render json: 
  end
end
