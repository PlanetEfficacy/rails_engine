class Api::V1::Invoices::SearchController < ApplicationController
  def show
    render json: InvoiceSearch.new(params).find
  end
end
