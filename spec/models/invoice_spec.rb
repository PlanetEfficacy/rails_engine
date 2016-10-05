require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { should belong_to(:merchant) }
  it { should belong_to(:customer) }
  it { should have_many(:transactions) }
  it { should have_many(:invoice_items) }

  it "can return a random invoice" do
    create_list(:invoice, 2)
    invoice = Invoice.random
    expect(invoice).to be_instance_of(Invoice)
  end

  it "has a revenue that is the total of each invoice items subtotal" do
    invoice = create(:invoice)
    create_list(:invoice_item, 2,
                invoice_id: invoice.id,
                quantity: 2,
                unit_price: 10)
    expect(invoice.revenue).to eq(40)
  end
end

# Q   UP   Subtotal
# 2 * 10 = 20
# 3 * 10 = 30
#   Total  50
# ___________
# 5 * 20 = 100
