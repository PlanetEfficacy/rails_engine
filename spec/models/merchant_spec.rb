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

    expect(Merchant.total_revenue_by_date(date)).to eq(expected_return)
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

  it "can return the customer who has conducted the most total number of successful transactions" do
    merchant = create(:merchant)
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    customer_1_invoices = create_list(:invoice, 2, customer_id: customer_1.id, merchant_id: merchant.id)
    customer_2_invoice = create(:invoice, customer_id: customer_2.id, merchant_id: merchant.id)
    create(:transaction, invoice_id: customer_2_invoice.id, result: "success")
    customer_1_invoices.each do |invoice|
      create(:transaction, invoice_id: invoice.id, result: "success")
    end

    expect(merchant.favorite_customer).to eq(customer_1)
  end

  it "can return top x merchants ranked by total revenue" do
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
      expect(Merchant.top_x(2).first).to eq(merchant_1)
      expect(Merchant.top_x(2).last).to eq(merchant_2)
  end
end
