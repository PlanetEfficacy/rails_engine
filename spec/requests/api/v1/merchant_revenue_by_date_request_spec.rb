require 'rails_helper'

describe "get request to merchants revenue with date parameter" do
  it "returns the total revenue for date x from all merchants" do
    date = "2012-03-16 11:55:05"
    merchant = create(:merchant)
    invoices = create_list(:invoice, 2,
                            created_at: date,
                            merchant_id: merchant.id)

    invoices.each do |invoice|
      create(:transaction,
              invoice_id: invoice.id,
              result: "success")
      create(:invoice_item,
              invoice_id: invoice.id,
              unit_price: 1000,
              quantity: 2)
    end

    get "/api/v1/merchants/#{merchant.id}/revenue"
    revenue = JSON.parse(response.body)

    expected_return = {"total_revenue" => "40.00"}
    expect(response).to be_success
    expect(revenue).to eq({"total_revenue" => "40.00"})
  end
end
