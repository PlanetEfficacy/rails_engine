require 'rails_helper'

describe "invoices with items" do
  it "returns a list of items associated with invoice" do
    invoice = create(:invoice)
    items = create_list(:item, 2)
    invoice_items1 = create(:invoice_item, invoice_id: invoice.id, item_id: items.first.id)
    invoice_items2 = create(:invoice_item, invoice_id: invoice.id, item_id: items.last.id)
  
    get "/api/v1/invoices/#{invoice.id}/items"
    raw_items = JSON.parse(response.body)
    
    expected_item_ids = items.map do |item|
      item.id 
    end
    
    expect(response).to be_success
    expect(raw_items).to be_instance_of(Array)
    expect(raw_items.count).to eq(2)
    
    raw_items.each do |item|
      expect(expected_item_ids).to include(item["id"])
    end
  end
end