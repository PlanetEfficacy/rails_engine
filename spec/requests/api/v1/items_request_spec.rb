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
    new_item = create(:item)
    get "/api/v1/items/#{new_item.id}"
    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item.class).to eq(Hash)
    expect(item["name"]).to eq(Item.first.name)
    expect(item["description"]).to eq(new_item.description)
  end

  it "finds a single item by id" do
    new_item = create(:item)
    get "/api/v1/items/find?id=#{new_item.id}"
    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(new_item.id)
  end

  it "finds a single item by name without regard to case" do
    new_item = create(:item)
    get "/api/v1/items/find?name=#{new_item.name.upcase}"
    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["name"]).to eq(new_item.name)
  end

  it "finds a single item by description without regard to case" do
    new_item = create(:item)
    get "/api/v1/items/find?description=#{new_item.description.upcase}"
    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["description"]).to eq(new_item.description)
  end

  it "finds a single item by unit price" do
    new_item = create(:item)
    get "/api/v1/items/find?unit_price=#{new_item.unit_price}"
    item = JSON.parse(response.body)
    expected_price = "#{'%.2f' % (new_item.unit_price/100.0)}"

    expect(response).to be_success
    expect(item["unit_price"]).to eq(expected_price)
  end

  it "finds a single item by merchant" do
    new_item = create(:item)
    get "/api/v1/items/find?merchant_id=#{new_item.merchant.id}"
    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["merchant_id"]).to eq(new_item.merchant.id)
  end

  it "finds a single item by updated at" do
    new_item = create(:item)
    get "/api/v1/items/find?updated_at=#{new_item.updated_at}"
    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(new_item.id)
  end

  it "finds a single item by created at" do
    new_item = create(:item)
    get "/api/v1/items/find?created_at=#{new_item.created_at}"
    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(new_item.id)
  end

  it "finds a random item" do
    create_list(:item, 2)
    get "/api/v1/items/random"
    item = JSON.parse(response.body)
    item_ids = Item.all.map { |item| item.id }

    expect(response).to be_success
    expect(item_ids).to include(item["id"])
  end

  it "finds all items by id" do
    new_items = create_list(:item, 2)
    get "/api/v1/items/find_all?id=#{new_items.first.id}"
    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items).to be_instance_of(Array)
    expect(items.first["id"]).to eq(new_items.first.id)
  end

  it "finds all items by name without regard to case" do
    create_list(:item, 2, name: "thingy")
    get "/api/v1/items/find_all?name=THINGY"
    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items).to be_instance_of(Array)
    items.each do |item|
      expect(item["name"]).to eq("thingy")
    end
  end

  it "finds all items by description without regard to case" do
    create_list(:item, 2, description: "This thingy is huge.")
    get "/api/v1/items/find_all?description=THIS THINGY IS HUGE."
    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items).to be_instance_of(Array)
    items.each do |item|
      expect(item["description"]).to eq("This thingy is huge.")
    end
  end

  it "finds all items by unit price" do
    create_list(:item, 2, unit_price: 1000)
    get "/api/v1/items/find_all?unit_price=1000"
    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items).to be_instance_of(Array)
    items.each do |item|
      expect(item["unit_price"]).to eq("10.00")
    end
  end

  it "finds all items by merchant" do
    merchant = create(:merchant)
    create_list(:item, 2, merchant: merchant)
    get "/api/v1/items/find_all?merchant_id=#{merchant.id}"
    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items).to be_instance_of(Array)
    items.each do |item|
      expect(item["merchant_id"]).to eq(merchant.id)
    end
  end
end
