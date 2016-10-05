class Api::V1::Merchants::CustomersController < ApplicationController
  def index
    customers = Merchant.find(params["id"]).customers
                        .joins(:invoices)
                        .joins(:transactions)
                        .where(transactions: {result: "failed"})
    render json: customers
  end
end
