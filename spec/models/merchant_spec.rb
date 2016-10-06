require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many(:invoices) }
  it { should have_many(:customers) }
  it { should have_many(:invoice_items) }
  it { should have_many(:transactions) }


  it "can return a random merchant" do
    create_list(:merchant, 2)
    merchant = Merchant.random
    expect(merchant).to be_instance_of(Merchant)
  end

  it "can return the total revenue for all Merchants for a given day" do
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

    expected_return = {"total_revenue" => "40.00"}

    expect(Merchant.total_revenue_for_date(date)).to eq(expected_return)
  end

  it "can return customers with pending invoices" do
    merchant = create(:merchant)
    new_customers = create_list(:customer, 2)
    invoice_1 = create(:invoice, customer_id: new_customers.first.id, merchant_id: merchant.id)
    invoice_2 = create(:invoice, customer_id: new_customers.last.id, merchant_id: merchant.id)
    create(:transaction, invoice_id: invoice_1.id, result: "failed")
    create(:transaction, invoice_id: invoice_2.id, result: "success")

    customers = merchant.customers_with_pending_invoices

    expect(customers.count).to eq(1)
    expect(customers.first).to eq(new_customers.first)
  end
end
