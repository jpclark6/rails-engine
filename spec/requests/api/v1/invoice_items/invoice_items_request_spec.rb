require 'rails_helper'

describe "Invoice items API" do
  it "sends a list of invoice items" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items.json'

    expect(response).to be_successful

    ii_data = JSON.parse(response.body)

    expect(ii_data["data"].length).to eq(3)

    expect(ii_data["data"][0]["attributes"]["item_id"]).to eq(InvoiceItem.first.item_id)
    expect(ii_data["data"][1]["attributes"]["item_id"]).to eq(InvoiceItem.second.item_id)
    expect(ii_data["data"][2]["attributes"]["item_id"]).to eq(InvoiceItem.third.item_id)
    expect(ii_data["data"][2]["type"]).to eq("invoice_item")

    expect(ii_data["data"][0]["attributes"]["id"]).to eq(InvoiceItem.first.id)
    expect(ii_data["data"][0]["attributes"]["item_id"]).to eq(InvoiceItem.first.item_id)
    expect(ii_data["data"][0]["attributes"]["invoice_id"]).to eq(InvoiceItem.first.invoice_id)
    expect(ii_data["data"][0]["attributes"]["quantity"]).to eq(InvoiceItem.first.quantity)
    unit_price = sprintf('%.2f', (InvoiceItem.first.unit_price/100.0))
    expect(ii_data["data"][0]["attributes"]["unit_price"]).to eq(unit_price)
  end
  it "sends data on one invoice item" do
    create(:invoice_item)

    get "/api/v1/invoice_items/#{InvoiceItem.first.id}.json"

    expect(response).to be_successful

    invoice_data = JSON.parse(response.body)

    expect(invoice_data["data"].length).to eq(3)

    expect(invoice_data["data"]["attributes"]["item_id"]).to eq(InvoiceItem.first.item_id)
    expect(invoice_data["data"]["attributes"]["invoice_id"]).to eq(InvoiceItem.first.invoice_id)
    expect(invoice_data["data"]["attributes"]["quantity"]).to eq(InvoiceItem.first.quantity)
    unit_price = sprintf('%.2f', (InvoiceItem.first.unit_price/100.0))
    expect(invoice_data["data"]["attributes"]["unit_price"]).to eq(unit_price)
    expect(invoice_data["data"]["type"]).to eq("invoice_item")
  end

  describe 'can find invoice items from parameters' do
    before(:each) do
      @ii_1 = create(:invoice_item, created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-23 14:54:09 UTC')#, item_id: 1, invoice_id: 1, quantity: 2, unit_price: 100, created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC')
      @ii_2 = create(:invoice_item, created_at: '2012-03-28 14:54:09 UTC', updated_at: '2012-03-24 14:54:09 UTC')#, item_id: 2, invoice_id: 1, quantity: 3, unit_price: 200, created_at: '2012-04-27 14:54:09 UTC', updated_at: '2012-04-27 14:54:09 UTC')
      @ii_3 = create(:invoice_item, created_at: '2012-03-29 14:54:09 UTC', updated_at: '2012-03-25 14:54:09 UTC')#, item_id: 3, invoice_id: 2, quantity: 4, unit_price: 300, created_at: '2012-05-27 14:54:09 UTC', updated_at: '2012-05-27 14:54:09 UTC')
      @ii_4 = create(:invoice_item, created_at: '2012-03-23 14:54:09 UTC', updated_at: '2012-03-26 14:54:09 UTC')#, item_id: 4, invoice_id: 2, quantity: 5, unit_price: 400, created_at: '2012-06-27 14:54:09 UTC', updated_at: '2012-06-27 14:54:09 UTC')
      @ii_5 = create(:invoice_item, created_at: '2012-03-24 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC')#, item_id: 5, invoice_id: 2, quantity: 6, unit_price: 500, created_at: '2012-07-27 14:54:09 UTC', updated_at: '2012-07-27 14:54:09 UTC')
    end

    it 'can find by id' do
      get "/api/v1/invoice_items/find?id=#{@ii_2.id}"

      expect(response).to be_successful

      ii_data = JSON.parse(response.body)

      expect(ii_data.length).to eq(1)
      expect(ii_data["data"].length).to eq(3)

      expect(ii_data["data"]["id"]).to eq(@ii_2.id.to_s)
      expect(ii_data["data"]["type"]).to eq("invoice_item")
      expect(ii_data["data"]["attributes"]["id"]).to eq(@ii_2.id)
      expect(ii_data["data"]["attributes"]["item_id"]).to eq(@ii_2.item_id)
      expect(ii_data["data"]["attributes"]["invoice_id"]).to eq(@ii_2.invoice_id)
      expect(ii_data["data"]["attributes"]["quantity"]).to eq(@ii_2.quantity)
      unit_price = sprintf('%.2f', (@ii_2.unit_price/100.0))
      expect(ii_data["data"]["attributes"]["unit_price"]).to eq(unit_price)
    end

    it 'can find by item_id' do
      get "/api/v1/invoice_items/find?item_id=#{@ii_2.item_id}"

      expect(response).to be_successful

      ii_data = JSON.parse(response.body)

      expect(ii_data.length).to eq(1)
      expect(ii_data["data"].length).to eq(3)

      expect(ii_data["data"]["id"]).to eq(@ii_2.id.to_s)
      expect(ii_data["data"]["type"]).to eq("invoice_item")
      expect(ii_data["data"]["attributes"]["id"]).to eq(@ii_2.id)
      expect(ii_data["data"]["attributes"]["item_id"]).to eq(@ii_2.item_id)
      expect(ii_data["data"]["attributes"]["invoice_id"]).to eq(@ii_2.invoice_id)
      expect(ii_data["data"]["attributes"]["quantity"]).to eq(@ii_2.quantity)
      unit_price = sprintf('%.2f', (@ii_2.unit_price/100.0))
      expect(ii_data["data"]["attributes"]["unit_price"]).to eq(unit_price)
    end

    it 'can find by invoice_id' do
      get "/api/v1/invoice_items/find?invoice_id=#{@ii_2.invoice_id}"

      expect(response).to be_successful

      ii_data = JSON.parse(response.body)

      expect(ii_data.length).to eq(1)
      expect(ii_data["data"].length).to eq(3)

      expect(ii_data["data"]["id"]).to eq(@ii_2.id.to_s)
      expect(ii_data["data"]["type"]).to eq("invoice_item")
      expect(ii_data["data"]["attributes"]["id"]).to eq(@ii_2.id)
      expect(ii_data["data"]["attributes"]["item_id"]).to eq(@ii_2.item_id)
      expect(ii_data["data"]["attributes"]["invoice_id"]).to eq(@ii_2.invoice_id)
      expect(ii_data["data"]["attributes"]["quantity"]).to eq(@ii_2.quantity)
      unit_price = sprintf('%.2f', (@ii_2.unit_price/100.0))
      expect(ii_data["data"]["attributes"]["unit_price"]).to eq(unit_price)
    end

    it 'can find by quantity' do
      get "/api/v1/invoice_items/find?quantity=#{@ii_2.quantity}"

      expect(response).to be_successful

      ii_data = JSON.parse(response.body)

      expect(ii_data.length).to eq(1)
      expect(ii_data["data"].length).to eq(3)

      expect(ii_data["data"]["id"]).to eq(@ii_2.id.to_s)
      expect(ii_data["data"]["type"]).to eq("invoice_item")
      expect(ii_data["data"]["attributes"]["id"]).to eq(@ii_2.id)
      expect(ii_data["data"]["attributes"]["item_id"]).to eq(@ii_2.item_id)
      expect(ii_data["data"]["attributes"]["invoice_id"]).to eq(@ii_2.invoice_id)
      expect(ii_data["data"]["attributes"]["quantity"]).to eq(@ii_2.quantity)
      unit_price = sprintf('%.2f', (@ii_2.unit_price/100.0))
      expect(ii_data["data"]["attributes"]["unit_price"]).to eq(unit_price)
    end

    it 'can find by unit_price' do
      unit_price = sprintf('%.2f', (@ii_2.unit_price/100.0))
      get "/api/v1/invoice_items/find?unit_price=#{unit_price}"

      expect(response).to be_successful

      ii_data = JSON.parse(response.body)

      expect(ii_data.length).to eq(1)
      expect(ii_data["data"].length).to eq(3)

      expect(ii_data["data"]["id"]).to eq(@ii_2.id.to_s)
      expect(ii_data["data"]["type"]).to eq("invoice_item")
      expect(ii_data["data"]["attributes"]["id"]).to eq(@ii_2.id)
      expect(ii_data["data"]["attributes"]["item_id"]).to eq(@ii_2.item_id)
      expect(ii_data["data"]["attributes"]["invoice_id"]).to eq(@ii_2.invoice_id)
      expect(ii_data["data"]["attributes"]["quantity"]).to eq(@ii_2.quantity)
      expect(ii_data["data"]["attributes"]["unit_price"]).to eq(unit_price)
    end

    it 'can find by created_at' do
      get "/api/v1/invoice_items/find?created_at=#{@ii_2.created_at}"

      expect(response).to be_successful

      ii_data = JSON.parse(response.body)

      expect(ii_data.length).to eq(1)
      expect(ii_data["data"].length).to eq(3)

      expect(ii_data["data"]["id"]).to eq(@ii_2.id.to_s)
      expect(ii_data["data"]["type"]).to eq("invoice_item")
      expect(ii_data["data"]["attributes"]["id"]).to eq(@ii_2.id)
      expect(ii_data["data"]["attributes"]["item_id"]).to eq(@ii_2.item_id)
      expect(ii_data["data"]["attributes"]["invoice_id"]).to eq(@ii_2.invoice_id)
      expect(ii_data["data"]["attributes"]["quantity"]).to eq(@ii_2.quantity)
      unit_price = sprintf('%.2f', (@ii_2.unit_price/100.0))
      expect(ii_data["data"]["attributes"]["unit_price"]).to eq(unit_price)
    end

    it 'can find by updated_at' do
      get "/api/v1/invoice_items/find?updated_at=#{@ii_2.updated_at}"

      expect(response).to be_successful

      ii_data = JSON.parse(response.body)

      expect(ii_data.length).to eq(1)
      expect(ii_data["data"].length).to eq(3)

      expect(ii_data["data"]["id"]).to eq(@ii_2.id.to_s)
      expect(ii_data["data"]["type"]).to eq("invoice_item")
      expect(ii_data["data"]["attributes"]["id"]).to eq(@ii_2.id)
      expect(ii_data["data"]["attributes"]["item_id"]).to eq(@ii_2.item_id)
      expect(ii_data["data"]["attributes"]["invoice_id"]).to eq(@ii_2.invoice_id)
      expect(ii_data["data"]["attributes"]["quantity"]).to eq(@ii_2.quantity)
      unit_price = sprintf('%.2f', (@ii_2.unit_price/100.0))
      expect(ii_data["data"]["attributes"]["unit_price"]).to eq(unit_price)
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

    it 'can find all by id' do
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

    it 'can find all by first name' do
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

    it 'can find all by last name' do
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

    it 'can find all by created at date' do
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

    it 'can find all by updated at date' do
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

  it 'can return a random customer' do
    create_list(:customer, 5)

    get "/api/v1/customers/random.json"

    expect(response).to be_successful

    customers_data = JSON.parse(response.body)

    expect(customers_data.length).to eq(1)
    expect(customers_data["data"].length).to eq(3)
    expect(customers_data["data"].keys). to eq(["id", "type", "attributes"])
    expect(customers_data["data"]["type"]). to eq("customer")
    expect(customers_data["data"]["attributes"].keys). to eq(["id", "first_name", "last_name"])
  end
end