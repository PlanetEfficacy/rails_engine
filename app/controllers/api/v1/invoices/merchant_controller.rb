class Api::V1::Invoices::MerchantController < ApplicationController
  def show
    render json: Merchant.joins(:invoices).where(invoices: {id: params[:id]})                    
  end
end