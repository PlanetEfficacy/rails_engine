require 'rails_helper'

describe "get request to single item's best day" do
  it "returns date (or dates in case of tie) with most sales for item by invoice date" do
    item_1 = create(:item)
    invoice_most = create(:invoice)
    invoice_least = create(:invoice)
    invoice_item_most = create(:invoice_item,
                                item_id: item_1.id,
                                invoice_id: invoice_most.id,
                                quantity: 2)
    invoice_item_least = create(:invoice_item,
                                item_id: item_1.id,
                                invoice_id: invoice_least.id,
                                quantity: 1)

    get "/api/v1/items/#{item_1.id}/best_day"
    date = JSON.parse(response.body)
    expected_date = invoice_most.created_at.to_i
    actual_date = DateTime.parse(date["best_day"]).to_i

    expect(response).to be_success
    expect(date).to be_instance_of(Hash)
    expect(actual_date).to eq(expected_date)
  end
end
