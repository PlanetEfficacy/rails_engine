class Api::V1::Merchants::AllItemsController < ApplicationController
  def index
    render json: Merchant.most_items_sold(params["quantity"])
  end
end
