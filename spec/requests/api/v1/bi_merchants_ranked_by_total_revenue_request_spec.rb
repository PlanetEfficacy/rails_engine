require 'rails_helper'

describe "get request to merchants most_revenue" do
  it "returns the top x merchants ranked by total revenue" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    item_1 = create(:item, merchant_id: merchant_1.id, unit_price: 1000)
    item_2 = create(:item, merchant_id: merchant_2.id, unit_price: 1000)
    invoice_1 = create(:invoice, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, merchant_id: merchant_2.id)
    invoice_item_1 = create(:invoice_item,
                            invoice_id: invoice_1.id,
                            item_id: item_1.id,
                            quantity: 2,
                            unit_price: 1000)
    invoice_item_2 = create(:invoice_item,
                            invoice_id: invoice_2.id,
                            item_id: item_2.id,
                            quantity: 1,
                            unit_price: 1000)
    create(:transaction, invoice_id: invoice_1.id, result: "success")
    create(:transaction, invoice_id: invoice_2.id, result: "success")

    get "/api/v1/merchants/most_revenue?quantity=2"
    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.first["id"]).to eq(merchant_1.id)
    expect(merchants.last["id"]).to eq(merchant_2.id)
  end
end
# GET /api/v1/merchants/most_revenue?quantity=x
# returns the top x merchants ranked by total revenue
