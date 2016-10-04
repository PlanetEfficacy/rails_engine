require 'rails_helper'

RSpec.describe InvoiceItemSearch, type: :model do
  it "has and id that is a number" do
    params = {"id"=>"200"}
    search = InvoiceItemSearch.new(params)

    expect(search.id).to eq(200)
  end

  it "returns an invoice item from the id paramater" do
    invoice_item = create(:invoice_item)
    params = {"id"=>invoice_item.id.to_s}
    search = InvoiceItemSearch.new(params)

    expect(search.find).to eq(invoice_item)
  end

  it "has a quantity that is a number" do
    params = {"quantity" => "2"}
    search = InvoiceItemSearch.new(params)

    expect(search.quantity).to eq(2)
  end

  it "returns an array of invoice items from the quantity paramater" do
    create_list(:invoice_item, 2, quantity: 2)
    invoice_item = create(:invoice_item, quantity: 3)

    params = {"quantity" => "2"}
    search = InvoiceItemSearch.new(params)

    expect(search.find.count).to eq(2)
    expect(search.find).to_not include(invoice_item)

    search.find.each do |invoice_item|
      expect(invoice_item.quantity).to eq(2)
    end
  end
end
