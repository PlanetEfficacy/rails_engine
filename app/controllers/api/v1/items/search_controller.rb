class Api::V1::Items::SearchController < ApplicationController
  def index
    render json: Item.where(item_params)
  end

  def show
    render json: Item.where(item_params).first
  end

  private

  def item_params
    fix_unit_price(params.permit( :id,
                                  :name,
                                  :description,
                                  :unit_price,
                                  :merchant_id,
                                  :updated_at,
                                  :created_at))
  end
end
