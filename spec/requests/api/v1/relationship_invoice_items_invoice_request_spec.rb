require 'rails_helper'

describe "get to invoice_items/:id/invoice" do
  it "returns the associated invoice" do
    new_invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice_id: new_invoice.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"
    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice).to be_instance_of(Hash)
    expect(invoice["id"]).to eq(new_invoice.id)
  end
end
