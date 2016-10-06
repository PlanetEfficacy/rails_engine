class Api::V1::Merchants::CustomersController < ApplicationController
  def index
    # byebug
    render json: Merchant.find(params["id"]).customers_with_pending_invoices
  end

  def show
    # byebug if params["id"] != "2"
    render json: Merchant.find(params["id"]).customers
                        .joins(:invoices)
                        .joins(:transactions)
                        .where(transactions: {result: "success"})
                        .max
  end
end
