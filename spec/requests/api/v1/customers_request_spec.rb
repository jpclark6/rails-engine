require 'rails_helper'

describe "Customers API" do
  it "sends a list of items" do
    create_list(:customer, 3)

    get '/api/v1/customers'

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
end
