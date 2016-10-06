class Api::V1::Merchants::AllRevenueController < ApplicationController
  def show
    date = params["date"]
    render json: Invoice.successful
                        .where(created_at: date)
                        .joins(:invoice_items)
                        .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def index
    quantity = params["quantity"]
    # render json:
  end
end
