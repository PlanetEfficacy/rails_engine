require 'rails_helper'

describe "invoices CRUD API" do
  it "returns a list of invoices" do
    create_list(:invoice, 3)
    get "/api/v1/invoices"
    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(3)
  end

  it "returns a single invoice" do
    new_invoice = create(:invoice)
    get "/api/v1/invoices/#{new_invoice.id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice.class).to eq(Hash)
    expect(invoice["id"]).to eq(new_invoice.id)
  end

  it "finds a single invoice by id" do
    new_invoice = create(:invoice)
    get "/api/v1/invoices/find?id=#{new_invoice.id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(new_invoice.id)
  end

  it "finds a single invoice by customer" do
    new_invoice = create(:invoice)
    get "/api/v1/invoices/find?customer_id=#{new_invoice.customer.id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["customer_id"]).to eq(new_invoice.customer.id)
  end

  it "finds a single invoice by merchant" do
    new_invoice = create(:invoice)
    get "/api/v1/invoices/find?merchant_id=#{new_invoice.merchant.id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["merchant_id"]).to eq(new_invoice.merchant.id)
  end

  it "finds a single invoice by status without regard to case" do
    new_invoice = create(:invoice)
    get "/api/v1/invoices/find?status=#{new_invoice.status.upcase}"
    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["status"]).to eq(new_invoice.status)
  end

  # it "finds a single invoice by created at" do
  #   new_invoice = create(:invoice)
  #   get "/api/v1/invoices/find?created_at=#{new_invoice.created_at}"
  #   invoice = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   binding.pry
  #   expect(invoice["id"]).to eq(new_invoice.id)
  # end

  it "finds a random invoice" do
    create_list(:invoice, 2)
    get "/api/v1/invoices/random"
    invoice = JSON.parse(response.body)
    invoice_ids = Invoice.all.map { |invoice| invoice.id }

    expect(response).to be_success
    expect(invoice_ids).to include(invoice["id"])
  end

  it "finds all invoices by id" do
    new_invoices = create_list(:invoice, 2)
    get "/api/v1/invoices/find_all?id=#{new_invoices.first.id}"
    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices).to be_instance_of(Array)
    expect(invoices.first["id"]).to eq(Invoice.first.id)
  end

  it "finds all invoices by customer" do
    customer = create(:customer)
    create_list(:invoice, 2, customer: customer)
    get "/api/v1/invoices/find_all?customer_id=#{customer.id}"
    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices).to be_instance_of(Array)
    invoices.each do |invoice|
      expect(invoice["customer_id"]).to eq(customer.id)
    end
  end

  it "finds all invoices by merchant" do
    merchant = create(:merchant)
    create_list(:invoice, 2, merchant: merchant)
    get "/api/v1/invoices/find_all?merchant_id=#{merchant.id}"
    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices).to be_instance_of(Array)
    invoices.each do |invoice|
      expect(invoice["merchant_id"]).to eq(merchant.id)
    end
  end

  it "finds all invoices by status without regard to case" do
    create_list(:invoice, 2, status: "shipped")
    get "/api/v1/invoices/find_all?status=SHIPPED"
    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices).to be_instance_of(Array)
    invoices.each do |invoice|
      expect(invoice["status"]).to eq("shipped")
    end
  end
end
