require 'rails_helper'

describe "merchants with invoices" do
  it "returns a list of invoices associated with merchant" do
    merchant = create(:merchant)
    invoices = create_list(:invoice, 2, merchant_id: merchant.id)
    create(:invoice)
    get "/api/v1/merchants/#{merchant.id}/invoices"
    raw_invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(raw_invoices).to be_instance_of(Array)
    expect(raw_invoices.count).to eq(2)
    
    raw_invoices.each do |invoice|
      expect(invoice["merchant_id"]).to eq(merchant.id)
    end
  end
end