require 'rails_helper'

describe "invoice with customer" do
  it "returns the customer associated with invoice" do
    customers = create_list(:customer, 2)
    invoice1 = create(:invoice, customer_id: customers.first.id)
  
    get "/api/v1/invoices/#{invoice1.id}/customer"
    raw_customer = JSON.parse(response.body)
    
    expect(response).to be_success
    expect(raw_customer).to be_instance_of(Hash)
    expect(customers.first.id).to eq(raw_customer["id"])
  end
end