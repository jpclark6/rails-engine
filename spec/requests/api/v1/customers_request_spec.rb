require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do
    x = create(:item)

    create_list(:customer, 3)

    get '/api/v1/customers.json'

    expect(response).to be_successful

    customers_data = JSON.parse(response.body)

    expect(customers_data["data"].length).to eq(3)

    expect(customers_data["data"][0]["attributes"]["first_name"]).to eq(Customer.all.first.first_name)
    expect(customers_data["data"][1]["attributes"]["first_name"]).to eq(Customer.all.second.first_name)
    expect(customers_data["data"][2]["attributes"]["first_name"]).to eq(Customer.all.third.first_name)

    expect(customers_data["data"][0]["attributes"]["last_name"]).to eq(Customer.all.first.last_name)
    expect(customers_data["data"][1]["attributes"]["last_name"]).to eq(Customer.all.second.last_name)
    expect(customers_data["data"][2]["attributes"]["last_name"]).to eq(Customer.all.third.last_name)
  end
  it "sends list data in correct format" do
    create_list(:customer, 3)

    get '/api/v1/customers.json'

    expect(response).to be_successful

    customers_data = JSON.parse(response.body)

    expect(customers_data.length).to eq(1)
    expect(customers_data["data"].length).to eq(3)

    expect(customers_data["data"][0]["id"]).to eq(Customer.first.id.to_s)
    expect(customers_data["data"][0]["type"]).to eq("customer")
    expect(customers_data["data"][0]["attributes"]["first_name"]).to eq(Customer.first.first_name)
    expect(customers_data["data"][0]["attributes"]["last_name"]).to eq(Customer.first.last_name)

    expect(customers_data["data"][1]["id"]).to eq(Customer.second.id.to_s)
    expect(customers_data["data"][1].length).to eq(3)
    expect(customers_data["data"][2]["id"]).to eq(Customer.third.id.to_s)
    expect(customers_data["data"][2].length).to eq(3)
  end
  it 'sends formatted data on one customer' do
    create_list(:customer, 3)
    customer = Customer.second

    get "/api/v1/customers/#{customer.id}.json"

    expect(response).to be_successful

    customers_data = JSON.parse(response.body)

    expect(customers_data.length).to eq(1)
    expect(customers_data["data"].length).to eq(3)

    expect(customers_data["data"]["id"]).to eq(customer.id.to_s)
    expect(customers_data["data"]["type"]).to eq("customer")
    expect(customers_data["data"]["attributes"]["first_name"]).to eq(customer.first_name)
    expect(customers_data["data"]["attributes"]["last_name"]).to eq(customer.last_name)
  end
end
