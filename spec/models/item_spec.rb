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
end
