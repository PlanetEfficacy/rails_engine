require 'rails_helper'

describe "get to customer/:id/invoices" do
  it "returns the associated invoices" do
    new_customer = create(:customer)
    new_invoices = create_list(:invoice, 2, customer_id: new_customer.id)

    get "/api/v1/customers/#{new_customer.id}/invoices"
    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices).to be_instance_of(Array)
    expect(invoices.count).to eq(2)

    invoices.each { |invoice| expect(invoice["customer_id"]).to eq(new_customer.id) }
  end
end
