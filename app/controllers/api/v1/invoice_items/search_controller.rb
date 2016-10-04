class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    render json: InvoiceItemSearch.new(params).find
  end
end
