require 'rails_helper'

describe "get request to merchant revenue" do
  it "returns the total revenue for merchant" do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    invoice1 = create(:invoice, merchant_id: merchant.id)
    invoice2 = create(:invoice, merchant_id: merchant2.id)
    create(:transaction, result: "success", invoice_id: invoice1.id)
    create(:invoice_item,
            invoice_id: invoice1.id,
            quantity: 2,
            unit_price: 25,
            created_at: "2012-03-16 11:55:05")
    invoice2 = create(:invoice, merchant_id: merchant.id)
    create(:transaction, result: "success", invoice_id: invoice2.id)
    create(:invoice_item,
            invoice_id: invoice2.id,
            quantity: 1,
            unit_price: 50,
            created_at: "2012-03-16 11:55:05")
    invoice2 = create(:invoice, merchant_id: merchant2.id)
    create(:transaction, result: "success", invoice_id: invoice2.id)
    create(:invoice_item,
            invoice_id: invoice2.id,
            quantity: 1,
            unit_price: 50,
            created_at: "2012-03-16 11:55:05")

    get "/api/v1/merchants/#{merchant.id}/revenue"
    revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(revenue).to eq(100)
  end
end