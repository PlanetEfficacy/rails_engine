require 'rails_helper'

RSpec.describe InvoiceSearch, type: :model do
  it "has and id that is a number" do
    params = {"id"=>"200"}
    search = InvoiceSearch.new(params)

    expect(search.id).to eq(200)
  end

  it "returns an invoice from the id paramater" do
    invoice = create(:invoice)
    params = {"id"=>invoice.id.to_s}
    search = InvoiceSearch.new(params)

    expect(search.find).to eq(invoice)
  end

  it "has a status that is a string" do
    params = {"status" => "shipped"}
    search = InvoiceSearch.new(params)

    expect(search.status).to eq("shipped")
  end

  it "returns an array of invoices from the quantity paramater" do
    create_list(:invoice, 2, status: "shipped")
    invoice = create(:invoice, status: "returned")

    params = {"status" => "shipped"}
    search = InvoiceSearch.new(params)

    expect(search.find.count).to eq(2)
    expect(search.find).to_not include(invoice)

    search.find.each do |invoice|
      expect(invoice.status).to eq("shipped")
    end
  end
end
