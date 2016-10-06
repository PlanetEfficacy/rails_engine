require 'rails_helper'

describe "get to items/:id/invoice_items" do
  it "returns the associated invoice items" do
    new_item = create(:item)
    invoice_item = create_list(:invoice_item, 2, item_id: new_item.id)

    get "/api/v1/items/#{new_item.id}/invoice_items"
    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items).to be_instance_of(Array)
    expect(invoice_items.count).to eq(2)

    invoice_items.each { |invoice_item| expect(invoice_item["item_id"]).to eq(new_item.id) }
  end
end
