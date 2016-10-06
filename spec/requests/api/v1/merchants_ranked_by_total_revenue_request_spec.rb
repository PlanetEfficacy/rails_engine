require 'rails_helper'

describe "get request to merchants most_revenue" do
  xit "returns the top x merchants ranked by total revenue" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    invoice_1 = create(:invoice, merchant_id: merchant_1.id)
    create(:invoice_item,
            invoice_id: invoice_1.id,
            quantity: 2,
            unit_price: 75)

    invoice_2 = create(:invoice, merchant_id: merchant_2.id)
    create(:invoice_item,
            invoice_id: invoice_2.id,
            quantity: 2,
            unit_price: 50)

    invoice_3 = create(:invoice, merchant_id: merchant_3.id)
    create(:invoice_item,
            invoice_id: invoice_2.id,
            quantity: 2,
            unit_price: 25)

    get "/api/v1/merchants/most_revenue?quantity=2"
    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.first["id"]).to eq(merchant_1.first.id)
    expect(merchants.last["id"]).to eq(merchant_2.last.id)
  end
end
# GET /api/v1/merchants/most_revenue?quantity=x
# returns the top x merchants ranked by total revenue
