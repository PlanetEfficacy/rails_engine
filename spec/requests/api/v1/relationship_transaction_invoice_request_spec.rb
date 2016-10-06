require 'rails_helper'

describe "get to transactions/:id/invoice" do
  it "returns the associated invoice" do
    new_invoice = create(:invoice)
    new_transaction = create(:transaction, invoice_id: new_invoice.id)

    get "/api/v1/transactions/#{new_transaction.id}/invoice"
    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice).to be_instance_of(Hash)
    expect(invoice["id"]).to eq(new_invoice.id)
  end
end
