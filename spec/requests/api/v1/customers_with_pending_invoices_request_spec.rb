require 'rails_helper'

describe "customers with pending invoices" do
  it "returns a list of customers" do
    merchant = create(:merchant)
    new_customers = create_list(:customer, 2)
    invoice_1 = create(:invoice, customer_id: new_customers.first.id, merchant_id: merchant.id)
    invoice_2 = create(:invoice, customer_id: new_customers.last.id, merchant_id: merchant.id)
    create(:transaction, invoice_id: invoice_1.id, result: "failed")
    create(:transaction, invoice_id: invoice_2.id, result: "success")
    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"
    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers).to be_instance_of(Array)
    expect(customers.count).to eq(1)
    expect(customers.first["id"]).to eq(new_customers.first.id)
  end
end
