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
end
