require 'rails_helper'

describe "get request to merchants revenue with date parameter" do
  it "returns the total revenue for date x from all merchants" do
    merchants = create_list(:merchant, 2)
    invoice_1 = create(:invoice, merchant_id: merchants.first.id)
    create(:invoice_item,
            invoice_id: invoice_1.id,
            quantity: 2,
            unit_price: 25,
            created_at: "2012-03-16 11:55:05")
    invoice_2 = create(:invoice, merchant_id: merchants.last.id)
    create(:invoice_item,
            invoice_id: invoice_2.id,
            quantity: 1,
            unit_price: 50,
            created_at: "2012-03-16 11:55:05")

    get "/api/v1/merchants/revenue?date=2012-03-16 11:55:05"
    revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(revenue).to eq(100)
  end
end
