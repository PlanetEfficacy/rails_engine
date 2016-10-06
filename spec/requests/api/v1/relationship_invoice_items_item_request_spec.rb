require 'rails_helper'

describe "get to invoice_items/:id/item" do
  it "returns the associated item" do
    new_item = create(:item)
    invoice_item = create(:invoice_item, item_id: new_item.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"
    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item).to be_instance_of(Hash)
    expect(item["id"]).to eq(new_item.id)
  end
end
