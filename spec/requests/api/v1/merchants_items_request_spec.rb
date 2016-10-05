require 'rails_helper'

describe "merchants with items" do
  it "returns a list of items associated with merchant" do
    merchant = create(:merchant)
    items = create_list(:item, 2, merchant_id: merchant.id)
    create(:item)
    get "/api/v1/merchants/#{merchant.id}/items"
    raw_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(raw_items).to be_instance_of(Array)
    expect(raw_items.count).to eq(2)
    
    raw_items.each do |item|
      expect(item["merchant_id"]).to eq(merchant.id)
    end
  end
end