require 'rails_helper'

describe "get to customer/:id/transactions" do
  it "returns the associated transactions" do
    new_customer = create(:customer)
    new_invoice = create(:invoice, customer_id: new_customer.id)
    new_transactions = create_list(:transaction, 2, invoice_id: new_invoice.id)

    get "/api/v1/customers/#{new_customer.id}/transactions"

    transactions = JSON.parse(response.body)
    expect(response).to be_success
    expect(transactions).to be_instance_of(Array)
    expect(transactions.count).to eq(2)
    transactions.each do |transaction|
      expect(transaction["invoice_id"]).to eq(new_invoice.id)
    end
  end
end
