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
    expect(customers_data["data"][0]["attributes"].length).to eq(3)

    expect(customers_data["data"][0]["id"]).to eq(Customer.first.id.to_s)
    expect(customers_data["data"][0]["type"]).to eq("customer")
    expect(customers_data["data"][0]["attributes"]["first_name"]).to eq(Customer.first.first_name)
    expect(customers_data["data"][0]["attributes"]["last_name"]).to eq(Customer.first.last_name)
    expect(customers_data["data"][0]["attributes"]["id"]).to eq(Customer.first.id)

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
    expect(customers_data["data"]["attributes"]["id"]).to eq(customer.id)
  end

  describe 'can find customer by customer parameters' do
    before(:each) do
      @cust_1 = create(:customer, created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC')
      @cust_2 = create(:customer, created_at: '2012-04-27 14:54:09 UTC', updated_at: '2012-04-27 14:54:09 UTC')
      @cust_3 = create(:customer, created_at: '2012-05-27 14:54:09 UTC', updated_at: '2012-05-27 14:54:09 UTC')
      @cust_4 = create(:customer, created_at: '2012-06-27 14:54:09 UTC', updated_at: '2012-06-27 14:54:09 UTC')
      @cust_5 = create(:customer, created_at: '2012-07-27 14:54:09 UTC', updated_at: '2012-07-27 14:54:09 UTC')
    end

    it 'can find by id' do
      get "/api/v1/customers/find?id=#{@cust_2.id}"

      expect(response).to be_successful

      customer_data = JSON.parse(response.body)

      expect(customer_data.length).to eq(1)
      expect(customer_data["data"].length).to eq(3)

      expect(customer_data["data"]["id"]).to eq(@cust_2.id.to_s)
      expect(customer_data["data"]["type"]).to eq("customer")
      expect(customer_data["data"]["attributes"]["first_name"]).to eq(@cust_2.first_name)
      expect(customer_data["data"]["attributes"]["last_name"]).to eq(@cust_2.last_name)
      expect(customer_data["data"]["attributes"]["id"]).to eq(@cust_2.id)
    end

    it 'can find by first name' do
      get "/api/v1/customers/find?first_name=#{@cust_2.first_name}"

      expect(response).to be_successful

      customer_data = JSON.parse(response.body)

      expect(customer_data.length).to eq(1)
      expect(customer_data["data"].length).to eq(3)

      expect(customer_data["data"]["id"]).to eq(@cust_2.id.to_s)
      expect(customer_data["data"]["type"]).to eq("customer")
      expect(customer_data["data"]["attributes"]["first_name"]).to eq(@cust_2.first_name)
      expect(customer_data["data"]["attributes"]["last_name"]).to eq(@cust_2.last_name)
      expect(customer_data["data"]["attributes"]["id"]).to eq(@cust_2.id)
    end

    it 'can find by last name' do
      get "/api/v1/customers/find?last_name=#{@cust_2.last_name}"

      expect(response).to be_successful

      customer_data = JSON.parse(response.body)

      expect(customer_data.length).to eq(1)
      expect(customer_data["data"].length).to eq(3)

      expect(customer_data["data"]["id"]).to eq(@cust_2.id.to_s)
      expect(customer_data["data"]["type"]).to eq("customer")
      expect(customer_data["data"]["attributes"]["first_name"]).to eq(@cust_2.first_name)
      expect(customer_data["data"]["attributes"]["last_name"]).to eq(@cust_2.last_name)
      expect(customer_data["data"]["attributes"]["id"]).to eq(@cust_2.id)
    end

    it 'can find by created at date' do
      get "/api/v1/customers/find?created_at=#{@cust_2.created_at}"

      expect(response).to be_successful

      customer_data = JSON.parse(response.body)

      expect(customer_data.length).to eq(1)
      expect(customer_data["data"].length).to eq(3)

      expect(customer_data["data"]["id"]).to eq(@cust_2.id.to_s)
      expect(customer_data["data"]["type"]).to eq("customer")
      expect(customer_data["data"]["attributes"]["first_name"]).to eq(@cust_2.first_name)
      expect(customer_data["data"]["attributes"]["last_name"]).to eq(@cust_2.last_name)
      expect(customer_data["data"]["attributes"]["id"]).to eq(@cust_2.id)
    end
    
    it 'can find by updated at date' do
      get "/api/v1/customers/find?updated_at=#{@cust_2.updated_at}"

      expect(response).to be_successful

      customer_data = JSON.parse(response.body)

      expect(customer_data.length).to eq(1)
      expect(customer_data["data"].length).to eq(3)

      expect(customer_data["data"]["id"]).to eq(@cust_2.id.to_s)
      expect(customer_data["data"]["type"]).to eq("customer")
      expect(customer_data["data"]["attributes"]["first_name"]).to eq(@cust_2.first_name)
      expect(customer_data["data"]["attributes"]["last_name"]).to eq(@cust_2.last_name)
      expect(customer_data["data"]["attributes"]["id"]).to eq(@cust_2.id)
    end
  end

  describe 'can find all customers by customer parameters' do
    before(:each) do
      @cust_1 = create(:customer, first_name: 'One', last_name: 'Two', created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC')
      @cust_2 = create(:customer, first_name: 'One', last_name: 'Two', created_at: '2012-04-27 14:54:09 UTC', updated_at: '2012-04-27 14:54:09 UTC')
      @cust_3 = create(:customer, first_name: 'Two', last_name: 'Three', created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-05-27 14:54:09 UTC')
      @cust_4 = create(:customer, first_name: 'Two', last_name: 'One', created_at: '2012-06-27 14:54:09 UTC', updated_at: '2012-04-27 14:54:09 UTC')
      @cust_5 = create(:customer, first_name: 'Three', last_name: 'One', created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-07-27 14:54:09 UTC')
    end

    it 'can find by id' do
      get "/api/v1/customers/find_all?id=#{@cust_2.id}"

      expect(response).to be_successful

      customer_data = JSON.parse(response.body)

      expect(customer_data.length).to eq(1)
      expect(customer_data["data"].length).to eq(1)

      expect(customer_data["data"][0]["id"]).to eq(@cust_2.id.to_s)
      expect(customer_data["data"][0]["type"]).to eq("customer")
      expect(customer_data["data"][0]["attributes"]["first_name"]).to eq(@cust_2.first_name)
      expect(customer_data["data"][0]["attributes"]["last_name"]).to eq(@cust_2.last_name)
      expect(customer_data["data"][0]["attributes"]["id"]).to eq(@cust_2.id)
    end

    it 'can find by first name' do
      get "/api/v1/customers/find_all?first_name=#{@cust_2.first_name}"

      expect(response).to be_successful

      customer_data = JSON.parse(response.body)

      expect(customer_data.length).to eq(1)
      expect(customer_data["data"].length).to eq(2)

      expect(customer_data["data"][0]["id"]).to eq(@cust_1.id.to_s)
      expect(customer_data["data"][0]["type"]).to eq("customer")
      expect(customer_data["data"][0]["attributes"]["first_name"]).to eq(@cust_1.first_name)
      expect(customer_data["data"][0]["attributes"]["last_name"]).to eq(@cust_1.last_name)
      expect(customer_data["data"][0]["attributes"]["id"]).to eq(@cust_1.id)

      expect(customer_data["data"][1]["id"]).to eq(@cust_2.id.to_s)
      expect(customer_data["data"][1]["type"]).to eq("customer")
      expect(customer_data["data"][1]["attributes"]["first_name"]).to eq(@cust_2.first_name)
      expect(customer_data["data"][1]["attributes"]["last_name"]).to eq(@cust_2.last_name)
      expect(customer_data["data"][1]["attributes"]["id"]).to eq(@cust_2.id)
    end

    it 'can find by last name' do
      get "/api/v1/customers/find_all?last_name=#{@cust_4.last_name}"

      expect(response).to be_successful

      customer_data = JSON.parse(response.body)

      expect(customer_data.length).to eq(1)
      expect(customer_data["data"].length).to eq(2)

      expect(customer_data["data"][0]["id"]).to eq(@cust_4.id.to_s)
      expect(customer_data["data"][0]["type"]).to eq("customer")
      expect(customer_data["data"][0]["attributes"]["first_name"]).to eq(@cust_4.first_name)
      expect(customer_data["data"][0]["attributes"]["last_name"]).to eq(@cust_4.last_name)
      expect(customer_data["data"][0]["attributes"]["id"]).to eq(@cust_4.id)

      expect(customer_data["data"][1]["id"]).to eq(@cust_5.id.to_s)
      expect(customer_data["data"][1]["type"]).to eq("customer")
      expect(customer_data["data"][1]["attributes"]["first_name"]).to eq(@cust_5.first_name)
      expect(customer_data["data"][1]["attributes"]["last_name"]).to eq(@cust_5.last_name)
      expect(customer_data["data"][1]["attributes"]["id"]).to eq(@cust_5.id)
    end

    it 'can find by created at date' do
      get "/api/v1/customers/find_all?created_at=#{@cust_1.created_at}"

      expect(response).to be_successful

      customer_data = JSON.parse(response.body)

      expect(customer_data.length).to eq(1)
      expect(customer_data["data"].length).to eq(3)

      expect(customer_data["data"][0]["id"]).to eq(@cust_1.id.to_s)
      expect(customer_data["data"][0]["type"]).to eq("customer")
      expect(customer_data["data"][0]["attributes"]["first_name"]).to eq(@cust_1.first_name)
      expect(customer_data["data"][0]["attributes"]["last_name"]).to eq(@cust_1.last_name)
      expect(customer_data["data"][0]["attributes"]["id"]).to eq(@cust_1.id)

      expect(customer_data["data"][1]["id"]).to eq(@cust_3.id.to_s)
      expect(customer_data["data"][1]["type"]).to eq("customer")
      expect(customer_data["data"][1]["attributes"]["first_name"]).to eq(@cust_3.first_name)
      expect(customer_data["data"][1]["attributes"]["last_name"]).to eq(@cust_3.last_name)
      expect(customer_data["data"][1]["attributes"]["id"]).to eq(@cust_3.id)

      expect(customer_data["data"][2]["id"]).to eq(@cust_5.id.to_s)
    end

    it 'can find by updated at date' do
      get "/api/v1/customers/find_all?updated_at=#{@cust_2.updated_at}"

      expect(response).to be_successful

      customer_data = JSON.parse(response.body)

      expect(customer_data.length).to eq(1)
      expect(customer_data["data"].length).to eq(2)

      expect(customer_data["data"][0]["id"]).to eq(@cust_2.id.to_s)
      expect(customer_data["data"][0]["type"]).to eq("customer")
      expect(customer_data["data"][0]["attributes"]["first_name"]).to eq(@cust_2.first_name)
      expect(customer_data["data"][0]["attributes"]["last_name"]).to eq(@cust_2.last_name)
      expect(customer_data["data"][0]["attributes"]["id"]).to eq(@cust_2.id)

      expect(customer_data["data"][1]["id"]).to eq(@cust_4.id.to_s)
      expect(customer_data["data"][1]["type"]).to eq("customer")
      expect(customer_data["data"][1]["attributes"]["first_name"]).to eq(@cust_4.first_name)
      expect(customer_data["data"][1]["attributes"]["last_name"]).to eq(@cust_4.last_name)
      expect(customer_data["data"][1]["attributes"]["id"]).to eq(@cust_4.id)
    end

  end
end
