class Api::V1::Invoices::ItemsController < ApplicationController
  def index
    render json: Item.joins(:invoice_items).joins(:invoices).where(invoices: {id: params[:id]})                    
  end
end
