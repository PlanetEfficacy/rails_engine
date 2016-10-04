require 'rails_helper'

describe "customers CRUD API" do
  it "returns a list of customers" do
    create_list(:customer, 3)
    get "/api/v1/customers"
    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.count).to eq(3)
    
    expect(customers.first["id"]).to eq(Customer.first.id)
    expect(customers.first["first_name"]).to eq(Customer.first.first_name)
    expect(customers.first["last_name"]).to eq(Customer.first.last_name)
    
    expect(customers.last["id"]).to eq(Customer.last.id)
    expect(customers.last["first_name"]).to eq(Customer.last.first_name)
    expect(customers.last["last_name"]).to eq(Customer.last.last_name)
  end

  it "returns a single customer" do
    customer = create(:customer)
    get "/api/v1/customers/#{customer.id}"
    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer.class).to eq(Hash)
    expect(customer["first_name"]).to eq(Customer.first.first_name)
  end
  
  it "finds a customer by id" do
    customer = create(:customer)
    get "/api/v1/customers/find?id=#{customer.id}"
    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer.class).to eq(Hash)
    expect(customer["id"]).to eq(Customer.first.id)
    expect(customer["first_name"]).to eq(Customer.first.first_name)
    expect(customer["last_name"]).to eq(Customer.first.last_name)
  end
  
  it "finds a single customer by first name without regard to case" do
    customer = create(:customer)
    get "/api/v1/customers/find?first_name=#{customer.first_name.upcase}"
    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer.class).to eq(Hash)
    expect(customer["id"]).to eq(Customer.first.id)
    expect(customer["first_name"]).to eq(Customer.first.first_name)
    expect(customer["last_name"]).to eq(Customer.first.last_name)
  end
  
  it "finds a single customer by last name without regard to case" do
    customer = create(:customer)
    get "/api/v1/customers/find?last_name=#{customer.last_name.upcase}"
    raw_customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(raw_customer.class).to eq(Hash)
    expect(raw_customer["id"]).to eq(Customer.first.id)
    expect(raw_customer["first_name"]).to eq(Customer.first.first_name)
    expect(raw_customer["last_name"]).to eq(Customer.first.last_name)
  end
  
  it "finds all customers by id" do
    customers = create_list(:customer, 2)
    get "/api/v1/customers/find_all?id=#{customers.first.id}"
    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer.class).to eq(Array)
    expect(customer.count).to eq(1)
  end
  
  it "finds all customers by first name without regard to case" do
    create_list(:customer, 2, first_name: "Bob")
    customer = create(:customer, first_name: "Larry")
    get "/api/v1/customers/find_all?first_name=BOB"
    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.class).to eq(Array)
    expect(customers.count).to eq(2)
    expect(customers).not_to include(customer)

    customers.each do |customer|
      expect(customer["first_name"]).to eq("Bob")
    end
  end
  
  it "finds all customers by last name without regard to case" do
    create_list(:customer, 2, last_name: "Smith")
    customer = create(:customer, last_name: "Anderson")
    get "/api/v1/customers/find_all?last_name=SMITH"
    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.class).to eq(Array)
    expect(customers.count).to eq(2)
    expect(customers).not_to include(customer)

    customers.each do |customer|
      expect(customer["last_name"]).to eq("Smith")
    end
  end
  
  it "finds a random customer" do
    create_list(:customer, 2)
    get "/api/v1/customers/random"
    customer = JSON.parse(response.body)
    customer_ids = Customer.all.map { |customer| customer.id }
    expect(response).to be_success
    expect(customer_ids).to include(customer["id"])
  end
end