require 'rails_helper'

describe "get to items/:id/merchant" do
  it "returns the associated merchant" do
    new_merchant = create(:merchant)
    new_item = create(:item, merchant_id: new_merchant.id)

    get "/api/v1/items/#{new_item.id}/merchant"
    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant).to be_instance_of(Hash)
    expect(merchant["id"]).to eq(new_merchant.id)
  end
end
