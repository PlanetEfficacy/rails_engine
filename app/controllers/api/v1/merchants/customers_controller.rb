class Api::V1::Merchants::CustomersController < ApplicationController
  def index
    render json: Merchant.find(params["id"]).customers
                        .joins(:invoices)
                        .joins(:transactions)
                        .where(transactions: {result: "failed"})
  end
end
