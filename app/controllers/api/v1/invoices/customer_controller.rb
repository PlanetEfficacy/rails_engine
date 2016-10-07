class Api::V1::Invoices::CustomerController < ApplicationController
  def show
    render json: Invoice.find(params[:id]).customer
    # render json: Customer.joins(:invoices).where(invoices: {id: invoice_id})                  
  end
end
