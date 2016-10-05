require 'rails_helper'

describe "invoices with transactions" do
  it "returns a list of transactions associated with invoice" do
    invoice = create(:invoice)
    transactions = create_list(:transaction, 2, invoice_id: invoice.id)
    create(:transaction)
    get "/api/v1/invoices/#{invoice.id}/transactions"
    raw_transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(raw_transactions).to be_instance_of(Array)
    expect(raw_transactions.count).to eq(2)
    
    raw_transactions.each do |transaction|
      expect(transaction["invoice_id"]).to eq(invoice.id)
    end
  end
end