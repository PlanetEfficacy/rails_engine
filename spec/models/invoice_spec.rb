require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { should belong_to(:merchant) }
  it { should belong_to(:customer) }
  it { should have_many(:transactions) }

  it "can return a random invoice" do
    create_list(:invoice, 2)
    invoice = Invoice.random
    expect(invoice).to be_instance_of(Invoice)
  end
end
