require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should have_many(:invoices) }
  it { should have_many(:merchants) }
  it { should have_many(:transactions) }

  it "can return a random customer" do
    create_list(:customer, 2)
    customer = Customer.random
    expect(customer).to be_instance_of(Customer)
  end
end
