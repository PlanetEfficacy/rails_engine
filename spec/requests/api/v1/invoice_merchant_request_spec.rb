require 'rails_helper'

describe "invoice with merchant" do
  it "returns the merchant associated with invoice" do
    merchants = create_list(:merchant, 2)
    invoice1 = create(:invoice, merchant_id: merchants.first.id)
  
    get "/api/v1/invoices/#{invoice1.id}/merchant"
    raw_merchant = JSON.parse(response.body)
    
    expect(response).to be_success
    expect(raw_merchant).to be_instance_of(Hash)
    expect(merchants.first.id).to eq(raw_merchant["id"])
  end
end