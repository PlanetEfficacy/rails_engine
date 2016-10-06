require 'rails_helper'

# GET /api/v1/merchants/:id/favorite_customer returns the customer
# who has conducted the most total number of successful transactions.
describe "get to merchants favorite customer" do
  it "returns the customer who has conducted the most total number of successful transactions" do
    merchant = create(:merchant)
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    customer_1_invoices = create_list(:invoice, 2, customer_id: customer_1.id, merchant_id: merchant.id)
    customer_2_invoice = create(:invoice, customer_id: customer_2.id, merchant_id: merchant.id)
    create(:transaction, invoice_id: customer_2_invoice.id, result: "success")
    customer_1_invoices.each do |invoice|
      create(:transaction, invoice_id: invoice.id, result: "success")
    end

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"
    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer).to be_instance_of(Hash)
    expect(customer["id"]).to eq(customer_1.id)
  end
end
