require 'rails_helper'

<<<<<<< HEAD
describe "get request to merchant revenue with date parameter" do
  it "returns the total revenue for date x from a single merchant" do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    invoice1 = create(:invoice, merchant_id: merchant.id, created_at: "2012-03-16 11:55:05")
    invoice2 = create(:invoice, merchant_id: merchant2.id, created_at: "2012-03-16 11:55:05")
    create(:transaction, result: "success", invoice_id: invoice1.id)
    create(:invoice_item,
            invoice_id: invoice1.id,
            quantity: 2,
            unit_price: 100)
    create(:transaction, result: "success", invoice_id: invoice2.id)
    create(:invoice_item,
            invoice_id: invoice2.id,
            quantity: 1,
            unit_price: 50,
            created_at: "2012-03-16 11:55:05")
    
=======
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
>>>>>>> master

    get "/api/v1/merchants/#{merchant.id}/revenue"
    revenue = JSON.parse(response.body)

    expected_return = {"total_revenue" => "40.00"}

    expect(response).to be_success
<<<<<<< HEAD
    expect(revenue).to eq({"revenue" => "2.00"})
=======
    expect(revenue).to eq({"total_revenue" => "40.00"})
>>>>>>> master
  end
end