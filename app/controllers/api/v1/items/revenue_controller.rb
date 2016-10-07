class Api::V1::Items::RevenueController < ApplicationController
  def index
    render json: Item.top_x_items(params["quantity"])
  end
end
