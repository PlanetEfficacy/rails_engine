require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to(:merchant) }
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices) }

  it "can return a random item" do
    create_list(:item, 2)
    item = Item.random
    expect(item).to be_instance_of(Item)
  end

  it "returns the top x items ranked by total revenue generated" do
    item_1 = create(:item)
    item_2 = create(:item)
    invoice = create(:invoice)
    invoice_item_1 = create(:invoice_item,
                              item_id: item_1.id,
                              invoice_id: invoice.id,
                              quantity: 2,
                              unit_price: 1000)
    invoice_item_2 = create(:invoice_item,
                              item_id: item_2.id,
                              invoice_id: invoice.id,
                              quantity: 1,
                              unit_price: 1000)
    create(:transaction, invoice_id: invoice.id, result: "success")

    expect(Item.top_x(2).first).to eq(item_1)
    expect(Item.top_x(2).last).to eq(item_2)
  end
end
