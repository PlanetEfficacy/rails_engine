require 'rails_helper'

describe "invoices CRUD API" do
  it "returns a list of invoices" do
    create_list(:invoice, 3)
    get "/api/v1/invoices"
    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(3)
  end

  it "returns a single invoice" do
    invoice = create(:invoice)
    get "/api/v1/invoices/#{invoice.id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice.class).to eq(Hash)
    expect(invoice["status"]).to eq(Invoice.first.status)
    expect(invoice["merchant_id"]).to eq(Invoice.first.merchant_id)
    expect(invoice["customer_id"]).to eq(Invoice.first.customer_id)
  end
end
