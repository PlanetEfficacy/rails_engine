require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  it { should belong_to(:invoice) }
  it { should belong_to(:item) }

  it "can return a random invoice item" do
    create_list(:invoice_item, 2)
    invoice_item = InvoiceItem.random
    expect(invoice_item).to be_instance_of(InvoiceItem)
  end
end
