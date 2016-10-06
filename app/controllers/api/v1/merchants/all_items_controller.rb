class Api::V1::Merchants::AllItemsController < ApplicationController
  def index 
    render json: Merchant.most_items_sold(params["quantity"])
  end
end

# returns the top x merchants ranked by total number 
# of items sold

