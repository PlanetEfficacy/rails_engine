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

    expect(Item.top_x_revenue(2).first).to eq(item_1)
    expect(Item.top_x_revenue(2).last).to eq(item_2)
  end
  # GET /api/v1/items/:id/best_day returns the date with
  # the most sales for the given item using the invoice date.
  # If there are multiple days with equal number of sales,
  # return the most recent day.
  xit "returns date with most sales for an item based on invoice date" do
    item_1 = create(:item)
    invoice_most = create(:invoice)
    invoice_least = create(:invoice)
    invoice_item_most = create(:invoice_item,
                                item_id: item_1.id,
                                invoice_id: invoice_most.id,
                                quantity: 2)
    invoice_item_least = create(:invoice_item,
                                item_id: item_1.id,
                                invoice_id: invoice_least.id,
                                quantity: 1)

    expected_item_1_date = invoice_most.created_at
    expect(item_1.best_day).to eq(expected_item_1_date)
  end

  xit "returns dates with most sales for item having multipe top days based on invoice date" do
    item = create(:item)
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)
    invoice_item_most = create(:invoice_item,
                                item_id: item.id,
                                invoice_id: invoice_1.id,
                                quantity: 1)
    invoice_item_least = create(:invoice_item,
                                item_id: item.id,
                                invoice_id: invoice_2.id,
                                quantity: 1)

    # expected_item_date = invoice_most.created_at
    best_days = item.top_date
  end
end
