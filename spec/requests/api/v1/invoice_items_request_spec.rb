require 'rails_helper'

describe "invoice items CRUD API" do
  it "returns a list of invoice items" do
    create_list(:invoice_item, 3)
    get "/api/v1/invoice_items"
    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(3)
  end

  it "returns a single invoice item" do
    new_invoice_item = create(:invoice_item)
    get "/api/v1/invoice_items/#{new_invoice_item.id}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item.class).to eq(Hash)
    expect(invoice_item["id"]).to eq(new_invoice_item.id)
  end

  it "finds a single invoice item by id" do
    new_invoice_item = create(:invoice_item)
    get "/api/v1/invoice_items/find?id=#{new_invoice_item.id}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["id"]).to eq(new_invoice_item.id)
  end

  it "finds a single invoice item by item" do
    new_invoice_item = create(:invoice_item)
    get "/api/v1/invoice_items/find?item_id=#{new_invoice_item.item.id}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["item_id"]).to eq(new_invoice_item.item.id)
  end

  it "finds a single invoice item by invoice" do
    new_invoice_item = create(:invoice_item)
    get "/api/v1/invoice_items/find?invoice_id=#{new_invoice_item.invoice.id}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["invoice_id"]).to eq(new_invoice_item.invoice.id)
  end

  it "finds a single invoice by quantity" do
    new_invoice_item = create(:invoice_item)
    get "/api/v1/invoice_items/find?quantity=#{new_invoice_item.quantity}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["quantity"]).to eq(new_invoice_item.quantity)
  end

  it "finds a single invoice by unit price" do
    new_invoice_item = create(:invoice_item)
    get "/api/v1/invoice_items/find?unit_price=#{new_invoice_item.unit_price}"
    invoice_item = JSON.parse(response.body)
    expected_price = "#{'%.2f' % (new_invoice_item.unit_price/100.0)}"

    expect(response).to be_success
    expect(invoice_item["unit_price"]).to eq(expected_price)
  end

  it "finds a random invoice" do
    create_list(:invoice_item, 2)
    get "/api/v1/invoice_items/random"
    invoice_item = JSON.parse(response.body)
    invoice_item_ids = InvoiceItem.all.map { |invoice_item| invoice_item.id }

    expect(response).to be_success
    expect(invoice_item_ids).to include(invoice_item["id"])
  end

  it "finds all invoice_items by id" do
    new_invoice_items = create_list(:invoice_item, 2)
    get "/api/v1/invoice_items/find_all?id=#{new_invoice_items.first.id}"
    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items).to be_instance_of(Array)
    expect(invoice_items.first["id"]).to eq(InvoiceItem.first.id)
  end

  it "finds all invoice items by item" do
    item = create(:item)
    create_list(:invoice_item, 2, item: item)
    get "/api/v1/invoice_items/find_all?item_id=#{item.id}"
    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items).to be_instance_of(Array)
    invoice_items.each do |invoice_item|
      expect(invoice_item["item_id"]).to eq(item.id)
    end
  end

  it "finds all invoice items by invoice" do
    invoice = create(:invoice)
    create_list(:invoice_item, 2, invoice: invoice)
    get "/api/v1/invoice_items/find_all?invoice_id=#{invoice.id}"
    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items).to be_instance_of(Array)
    invoice_items.each do |invoice_item|
      expect(invoice_item["invoice_id"]).to eq(invoice.id)
    end
  end

  it "finds all invoice_items by quantity" do
    create_list(:invoice_item, 2, quantity: 2)
    get "/api/v1/invoice_items/find_all?quantity=2"
    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items).to be_instance_of(Array)
    invoice_items.each do |invoice_item|
      expect(invoice_item["quantity"]).to eq(2)
    end
  end

  it "finds all invoice_items by unit price" do
    create_list(:invoice_item, 2, unit_price: 1000)
    get "/api/v1/invoice_items/find_all?unit_price=1000"
    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items).to be_instance_of(Array)
    invoice_items.each do |invoice_item|
      expect(invoice_item["unit_price"]).to eq("10.00")
    end
  end
end
