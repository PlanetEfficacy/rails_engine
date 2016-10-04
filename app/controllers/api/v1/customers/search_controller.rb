class Api::V1::Customers::SearchController < ApplicationController
  def show
    render json: CustomerSearch.new(params).find
  end
  
  def index 
    # render json: CustomerSearch.new(params).find_all
    render json: Customer.where(customer_params)
  end
  
  private
  
  def customer_params
    params.permit()
  end
end