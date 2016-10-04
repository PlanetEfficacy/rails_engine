require 'rails_helper'

describe "invoice items CRUD API" do
  it "returns a list of invoice items" do
    create_list(:invoice_item, 3)
    get "/api/v1/invoice_items"
    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(3)
    expect(invoice_items.first["id"]).to eq(InvoiceItem.first.id)
    expect(invoice_items.last["id"]).to eq(InvoiceItem.last.id)
  end

  it "returns a single invoice item" do
    invoice_item = create(:invoice_item)
    get "/api/v1/invoice_items/#{invoice_item.id}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item.class).to eq(Hash)
    expect(invoice_item["id"]).to eq(InvoiceItem.first.id)
  end

  it "can find by id" do
    new_invoice_item = create(:invoice_item)
    get "/api/v1/invoice_items/find?id=#{new_invoice_item.id}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item.class).to eq(Hash)
    expect(invoice_item["id"]).to eq(InvoiceItem.first.id)
  end

  it "can find by quantity" do
    create_list(:invoice_item, 2, quantity: 2)
    invoice_item = create(:invoice_item, quantity: 3)
    get "/api/v1/invoice_items/find?quantity=2"
    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.class).to eq(Array)
    expect(invoice_items.count).to eq(2)
    expect(invoice_items).not_to include(invoice_item)

    invoice_items.each do |invoice_item|
      expect(invoice_item["quantity"]).to eq(2)
    end
  end
end
