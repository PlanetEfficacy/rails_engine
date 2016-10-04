require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should belong_to(:invoice) }
  
  it "can return a random transaction" do
    create_list(:transaction, 2)
    transaction = Transaction.random
    expect(transaction).to be_instance_of(Transaction)
  end
end
