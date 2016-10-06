class Api::V1::Merchants::AllRevenueController < ApplicationController
  def show
    render json: Merchant.total_revenue_for_date(params["date"])
  end

  def index
    quantity = params["quantity"]
    # render json:
  end
end
