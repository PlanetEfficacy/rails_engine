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
  
  it "finds a merchant by id" do
    merchant = create(:merchant)
    get "/api/v1/merchants/find?id=#{merchant.id}"
    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant.class).to eq(Hash)
    expect(merchant["id"]).to eq(Merchant.first.id)
    expect(merchant["name"]).to eq(Merchant.first.name)
  end
  
  it "finds a single merchant by name without regard to case" do
    merchant = create(:merchant)
    get "/api/v1/merchants/find?name=#{merchant.name.upcase}"
    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant.class).to eq(Hash)
    expect(merchant["name"]).to eq(Merchant.first.name)
  end
  
  it "finds all merchants by id" do
    merchants = create_list(:merchant, 2)
    get "/api/v1/merchants/find_all?id=#{merchants.first.id}"
    raw_merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(raw_merchants.class).to eq(Array)
    expect(raw_merchants.count).to eq(1)

    raw_merchants.each do |merchant|
      expect(merchant["id"]).to eq(merchants.first.id)
    end
  end

  it "finds all merchants by name without regard to case" do
    create_list(:merchant, 2, name: "Bob Ross")
    merchant = create(:merchant, name: "David Robinson")
    get "/api/v1/merchants/find_all?name=BOB ROSS"
    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.class).to eq(Array)
    expect(merchants.count).to eq(2)
    expect(merchants).not_to include(merchant)

    merchants.each do |merchant|
      expect(merchant["name"]).to eq("Bob Ross")
    end
  end
  
  it "finds a random merchant" do
    create_list(:merchant, 2)
    get "/api/v1/merchants/random"
    merchant = JSON.parse(response.body)
    merchant_ids = Merchant.all.map { |merchant| merchant.id }
    expect(response).to be_success
    expect(merchant_ids).to include(merchant["id"])
  end
end