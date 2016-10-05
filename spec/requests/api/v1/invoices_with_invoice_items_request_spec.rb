require 'rails_helper'

describe "invoices with invoice_items" do
  it "returns a list of invoice_items associated with invoice" do
    invoice = create(:invoice)
    invoice_items = create_list(:invoice_item, 2, invoice_id: invoice.id)
    create(:invoice_item)
    get "/api/v1/invoices/#{invoice.id}/invoice_items"
    raw_invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(raw_invoice_items).to be_instance_of(Array)
    expect(raw_invoice_items.count).to eq(2)
    
    raw_invoice_items.each do |invoice_item|
      expect(invoice_item["invoice_id"]).to eq(invoice.id)
    end
  end
end