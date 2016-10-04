require 'rails_helper'

describe "merchants CRUD API" do
  it "returns a list of merchants" do
    create_list(:merchant, 3)
    get "/api/v1/merchants"
    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to eq(3)
    
    expect(merchants.first["id"]).to eq(Merchant.first.id)
    expect(merchants.first["name"]).to eq(Merchant.first.name)
    
    expect(merchants.last["id"]).to eq(Merchant.last.id)
    expect(merchants.last["name"]).to eq(Merchant.last.name)
  end

  it "returns a single merchant" do
    merchant = create(:merchant)
    get "/api/v1/merchants/#{merchant.id}"
    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant.class).to eq(Hash)
    expect(merchant["name"]).to eq(Merchant.first.name)
  end
end