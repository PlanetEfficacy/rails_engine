require 'rails_helper'

describe "invoices CRUD API" do
  it "returns a list of invoices" do
    create_list(:invoice, 3)
    get "/api/v1/invoices"
    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(3)
  end
end
