require 'rails_helper'

# GET /api/v1/merchants/:id/favorite_customer returns the customer
# who has conducted the most total number of successful transactions.
describe "get to customers favorite merchant" do
  it "returns the merchant who has the most transactions with that customer" do
    customer = create(:customer)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    customer_1_invoices = create_list(:invoice, 2, customer_id: customer.id, merchant_id: merchant_1.id)
    customer_2_invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant_2.id)
    create(:transaction, invoice_id: customer_2_invoice.id, result: "success")
    customer_1_invoices.each do |invoice|
      create(:transaction, invoice_id: invoice.id, result: "success")
    end

    get "/api/v1/customers/#{customer.id}/favorite_merchant"
    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant).to be_instance_of(Hash)
    expect(merchant["id"]).to eq(merchant_1.id)
  end
end