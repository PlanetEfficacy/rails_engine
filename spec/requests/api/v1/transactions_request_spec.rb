require 'rails_helper'

describe "transactions CRUD API" do
  it "returns a list of transactions" do
    new_transactions = create_list(:transaction, 3)
    get "/api/v1/transactions"
    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(3)
    expect(transactions.first["id"]).to eq(new_transactions.first.id)
    expect(transactions.first["credit_card_number"]).to eq(new_transactions.first.credit_card_number)
    expect(transactions.first["result"]).to eq(new_transactions.first.result)
    expect(transactions.first["invoice_id"]).to eq(new_transactions.first.invoice_id)

    expect(transactions.last["id"]).to eq(new_transactions.last.id)
    expect(transactions.last["credit_card_number"]).to eq(new_transactions.last.credit_card_number)
    expect(transactions.last["result"]).to eq(new_transactions.last.result)
    expect(transactions.last["invoice_id"]).to eq(new_transactions.last.invoice_id)
  end

  it "returns a single transaction" do
    transaction = create(:transaction)
    get "/api/v1/transactions/#{transaction.id}"
    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction.class).to eq(Hash)
    expect(transaction["credit_card_number"]).to eq(Transaction.first.credit_card_number)
    expect(transaction["result"]).to eq(Transaction.first.result)
    expect(transaction["invoice_id"]).to eq(Transaction.first.invoice_id)
  end

  it "finds a transaction by id" do
    transaction = create(:transaction)
    get "/api/v1/transactions/find?id=#{transaction.id}"
    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction.class).to eq(Hash)
    expect(transaction["id"]).to eq(Transaction.first.id)
    expect(transaction["credit_card_number"]).to eq(Transaction.first.credit_card_number)
    expect(transaction["result"]).to eq(Transaction.first.result)
    expect(transaction["invoice_id"]).to eq(Transaction.first.invoice_id)
  end

  it "finds a single transaction by result without regard to case" do
    transaction = create(:transaction)
    get "/api/v1/transactions/find?result=#{transaction.result.upcase}"
    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction.class).to eq(Hash)
    expect(transaction["result"]).to eq(Transaction.first.result)
  end

  it "finds all transactions by id" do
    transactions = create_list(:transaction, 2)
    get "/api/v1/transactions/find_all?id=#{transactions.first.id}"
    raw_transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(raw_transactions.class).to eq(Array)
    expect(raw_transactions.count).to eq(1)

    raw_transactions.each do |transaction|
      expect(transaction["id"]).to eq(transactions.first.id)
    end
  end

  it "finds all transactions by result without regard to case" do
    create_list(:transaction, 2, result: "success")
    transaction = create(:transaction, result: "failure")
    get "/api/v1/transactions/find_all?result=SUCCESS"
    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.class).to eq(Array)
    expect(transactions.count).to eq(2)
    expect(transactions).not_to include(transaction)

    transactions.each do |transaction|
      expect(transaction["result"]).to eq("success")
    end
  end

  it "finds a random transaction" do
    create_list(:transaction, 2)
    get "/api/v1/transactions/random"
    transaction = JSON.parse(response.body)
    transaction_ids = Transaction.all.map { |transaction| transaction.id }
    expect(response).to be_success
    expect(transaction_ids).to include(transaction["id"])
  end
end
