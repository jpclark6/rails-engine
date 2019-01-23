require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers.json'

    expect(response).to be_successful

    customers_data = JSON.parse(response.body)
    expect(customers_data[0]["data"].length).to eq(3)

    expect(customers_data[0]["data"][0]["first_name"]).to eq(Customer.all.first.first_name)
    expect(customers_data[0]["data"][1]["first_name"]).to eq(Customer.all.second.first_name)
    expect(customers_data[0]["data"][2]["first_name"]).to eq(Customer.all.third.first_name)

    expect(customers_data[0]["data"][0]["last_name"]).to eq(Customer.all.first.last_name)
    expect(customers_data[0]["data"][1]["last_name"]).to eq(Customer.all.second.last_name)
    expect(customers_data[0]["data"][2]["last_name"]).to eq(Customer.all.third.last_name)
  end
  it "sends data on one customer" do
    create_list(:customer, 3)

    get '/api/v1/customers.json'

    expect(response).to be_successful

    customers_data = JSON.parse(response.body)
    expect(customers_data[0].length).to eq(1)
    expect(customers_data[0]["data"].length).to eq(3)
    expect(customers_data[0]["data"]["type"].length).to eq(1)
    expect(customers_data[0]["data"]["attributes"].length).to eq(2)

    expect(customers_data[0]["data"][0]["id"]).to eq(Customer.first.id)
    expect(customers_data[0]["data"][0]["type"]).to eq("customer")
    expect(customers_data[0]["data"][0]["attributes"]["first_name"]).to eq(Customer.first.first_name)
    expect(customers_data[0]["data"][0]["attributes"]["last_name"]).to eq(Customer.first.last_name)

    expect(customers_data[0]["data"][1]["id"]).to eq(Customer.second.id)
    expect(customers_data[0]["data"][2]["id"]).to eq(Customer.third.id)

  end
end
