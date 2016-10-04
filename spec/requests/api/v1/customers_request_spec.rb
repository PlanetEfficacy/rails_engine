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
  
  it "can find by id" do
    customer = create(:customer)
    get "/api/v1/customers/find?id=#{customer.id}"
    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer.class).to eq(Hash)
    expect(customer["id"]).to eq(Customer.first.id)
    expect(customer["first_name"]).to eq(Customer.first.first_name)
    expect(customer["last_name"]).to eq(Customer.first.last_name)
  end
  
  it "can find all by first_name" do
    create_list(:customer, 2, first_name: "Bob")
    customer = create(:customer, first_name: "Larry")
    get "/api/v1/customer/find?first_name=Bob"
    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.class).to eq(Array)
    expect(customers.count).to eq(2)
    expect(customers).not_to include(customer)

    customers.each do |customer|
      expect(customer["first_name"]).to eq("Bob")
    end
  end
end