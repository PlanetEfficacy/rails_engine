require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  it { should belong_to(:invoice) }
  it { should belong_to(:item) }

  it "can return a random invoice item" do
    create_list(:invoice_item, 2)
    invoice_item = InvoiceItem.random
    expect(invoice_item).to be_instance_of(InvoiceItem)
  end

  it "has a line item subtotal" do
    invoice_item = create(:invoice_item, quantity: 2, unit_price: 10)
    expect(invoice_item.subtotal).to eq(20)
  end
end
