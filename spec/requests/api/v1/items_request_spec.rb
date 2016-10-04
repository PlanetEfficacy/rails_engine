require 'rails_helper'

describe "items CRUD API" do
  it "returns a list of items" do
    create_list(:item, 3)
    get "/api/v1/items"
    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end

  it "returns a single item" do
    item = create(:item)
    get "/api/v1/items/#{item.id}"
    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item.class).to eq(Hash)
    expect(item["name"]).to eq(Item.first.name)
    expect(item["description"]).to eq(Item.first.description)
  end

  it "finds a single item by name without regard to case" do
    item = create(:item)
    get "/api/v1/items/find?name=#{item.name.upcase}"
    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["name"]).to eq(Item.first.name)
  end
end
