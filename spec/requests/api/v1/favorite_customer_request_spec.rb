require 'rails_helper'

describe "get request to favorite_customer" do
  it "returns the customer who has conducted the most total number of successful transaction" do
    merchant = create(:merchant)
    new_customers = create_list(:customer, 2)
    invoice_1 = create(:invoice, customer_id: new_customers.first.id, merchant_id: merchant.id)
    invoice_2 = create(:invoice, customer_id: new_customers.last.id, merchant_id: merchant.id)
    invoice_3 = create(:invoice, customer_id: new_customers.last.id, merchant_id: merchant.id)
    create(:transaction, invoice_id: invoice_1.id, result: "success")
    create(:transaction, invoice_id: invoice_2.id, result: "success")
    create(:transaction, invoice_id: invoice_3.id, result: "success")
    get "/api/v1/merchants/#{merchant.id}/favorite_customer"
    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer).to be_instance_of(Hash)
    expect(customer["id"]).to eq(new_customers.last.id)
  end
end
