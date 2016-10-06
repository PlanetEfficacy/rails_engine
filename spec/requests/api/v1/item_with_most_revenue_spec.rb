require 'rails_helper'

describe "get request to most revenue item" do
  xit "returns the top x items ranked by total revenue generated" do
    new_items = create_list(:item, 1)
    invoices = create_list(:invoice, 2)
    invoice_item_1 = create(:invoice_item,
                            item_id: new_items.first.id,
                            invoice_id: invoices.first.id,
                            quantity: 10,
                            unit_price: 1000)
    invoice_item_2 = create(:invoice_item,
                            item_id: new_items.last.id,
                            invoice_id: invoices.last.id,
                            quantity: 1,
                            unit_price: 1000)

    get "/api/v1/items/most_revenue?quantity=1"
    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items).to be_instance_of(Array)
    expect(items.length).to eq(1)
    expect(items.first.id).to eq(new_items.first.id)

    get "/api/v1/items/most_revenue?quantity=2"
    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items).to be_instance_of(Array)
    expect(items.length).to eq(2)
    expect(items.first.id).to eq(new_items.first.id)
    expect(items.last.id).to eq(new_items.last.id)
  end
end
