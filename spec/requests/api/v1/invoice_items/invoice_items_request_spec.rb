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

  describe 'can find all invoice items by parameters' do
    before(:each) do
      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)

      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)

      @item_1 = create(:item, merchant: @merchant_1, unit_price: 250)
      @item_2 = create(:item, merchant: @merchant_1, unit_price: 1000)
      @item_3 = create(:item, merchant: @merchant_2, unit_price: 3000)
      @item_4 = create(:item, merchant: @merchant_2, unit_price: 4000)
      @item_5 = create(:item, merchant: @merchant_3, unit_price: 5000)
      @item_6 = create(:item, merchant: @merchant_3, unit_price: 6000)

      @invoice_1 = create(:invoice, merchant: @merchant_1, status: "shipped", updated_at: '2012-03-20 14:54:09 UTC', customer: @customer_1)
      @invoice_2 = create(:invoice, merchant: @merchant_2, status: "shipped", updated_at: '2012-03-21 14:54:09 UTC', customer: @customer_2)
      @invoice_3 = create(:invoice, merchant: @merchant_2, status: "shipped", updated_at: '2012-03-24 14:54:09 UTC', customer: @customer_3)
      @invoice_4 = create(:invoice, merchant: @merchant_3, status: "shipped", updated_at: '2012-03-24 14:54:09 UTC', customer: @customer_1)
      @invoice_5 = create(:invoice, merchant: @merchant_3, status: "shipped", updated_at: '2012-03-24 14:54:09 UTC', customer: @customer_2)

      @invoice_items_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 11, unit_price: 100)
      @invoice_items_2 = create(:invoice_item, item: @item_2, invoice: @invoice_1, quantity: 10, unit_price: 200)
      @invoice_items_3 = create(:invoice_item, item: @item_1, invoice: @invoice_2, quantity: 11, unit_price: 100)
      @invoice_items_4 = create(:invoice_item, item: @item_2, invoice: @invoice_2, quantity: 11, unit_price: 200)
      @invoice_items_5 = create(:invoice_item, item: @item_3, invoice: @invoice_3, quantity: 10, unit_price: 300)
      @invoice_items_7 = create(:invoice_item, item: @item_4, invoice: @invoice_3, quantity: 11, unit_price: 400)
      @invoice_items_8 = create(:invoice_item, item: @item_5, invoice: @invoice_4, quantity: 100, unit_price: 500)
      @invoice_items_8 = create(:invoice_item, item: @item_5, invoice: @invoice_5, quantity: 100, unit_price: 600)

      @transaction_1 = create(:transaction, invoice: @invoice_1, result: :success, updated_at: '2012-03-20 14:54:09 UTC')
      @transaction_2 = create(:transaction, invoice: @invoice_2, result: :success, updated_at: '2012-03-21 14:54:09 UTC')
      @transaction_3 = create(:transaction, invoice: @invoice_3, result: :success, updated_at: '2012-03-24 14:54:09 UTC')
      @transaction_4 = create(:transaction, invoice: @invoice_4, result: :success, updated_at: '2012-03-24 14:54:09 UTC')
      @transaction_5 = create(:transaction, invoice: @invoice_5, result: :failed, updated_at: '2012-03-24 14:54:09 UTC')
    end

    it 'can find all by id' do
      get "/api/v1/invoice_items/find_all?id=#{@invoice_items_2.id}"

      expect(response).to be_successful

      ii_data = JSON.parse(response.body)

      expect(ii_data.length).to eq(1)
      expect(ii_data["data"].length).to eq(1)

      expect(ii_data["data"][0]["id"]).to eq(@invoice_items_2.id.to_s)
      expect(ii_data["data"][0]["type"]).to eq("invoice_item")
      expect(ii_data["data"][0]["attributes"]["id"]).to eq(@invoice_items_2.id)
      expect(ii_data["data"][0]["attributes"]["item_id"]).to eq(@invoice_items_2.item_id)
      expect(ii_data["data"][0]["attributes"]["invoice_id"]).to eq(@invoice_items_2.invoice_id)
      expect(ii_data["data"][0]["attributes"]["quantity"]).to eq(@invoice_items_2.quantity)
      unit_price = sprintf('%.2f', (@invoice_items_2.unit_price/100.0))
      expect(ii_data["data"][0]["attributes"]["unit_price"]).to eq(unit_price)
    end

    it 'can find all by item id' do
      get "/api/v1/invoice_items/find_all?item_id=#{@invoice_items_2.item_id}"

      expect(response).to be_successful

      ii_data = JSON.parse(response.body)

      expect(ii_data.length).to eq(1)
      expect(ii_data["data"].length).to eq(2)

      expect(ii_data["data"][0]["id"]).to eq(@invoice_items_2.id.to_s)
      expect(ii_data["data"][0]["type"]).to eq("invoice_item")
      expect(ii_data["data"][0]["attributes"]["id"]).to eq(@invoice_items_2.id)
      expect(ii_data["data"][0]["attributes"]["item_id"]).to eq(@invoice_items_2.item.id)
      expect(ii_data["data"][0]["attributes"]["quantity"]).to eq(@invoice_items_2.quantity)
      unit_price = sprintf('%.2f', (@invoice_items_2.unit_price/100.0))
      expect(ii_data["data"][0]["attributes"]["unit_price"]).to eq(unit_price)

      expect(ii_data["data"][1]["id"]).to eq(@invoice_items_4.id.to_s)
      expect(ii_data["data"][1]["type"]).to eq("invoice_item")
      expect(ii_data["data"][1]["attributes"]["id"]).to eq(@invoice_items_4.id)
      expect(ii_data["data"][1]["attributes"]["item_id"]).to eq(@invoice_items_4.item.id)
      expect(ii_data["data"][1]["attributes"]["quantity"]).to eq(@invoice_items_4.quantity)
      unit_price = sprintf('%.2f', (@invoice_items_4.unit_price/100.0))
      expect(ii_data["data"][1]["attributes"]["unit_price"]).to eq(unit_price)
    end

    it 'can find all by invoice id' do
      get "/api/v1/invoice_items/find_all?invoice_id=#{@invoice_items_2.invoice_id}"

      expect(response).to be_successful

      ii_data = JSON.parse(response.body)

      expect(ii_data.length).to eq(1)
      expect(ii_data["data"].length).to eq(2)

      expect(ii_data["data"][0]["id"]).to eq(@invoice_items_1.id.to_s)
      expect(ii_data["data"][0]["type"]).to eq("invoice_item")
      expect(ii_data["data"][0]["attributes"]["id"]).to eq(@invoice_items_1.id)
      expect(ii_data["data"][0]["attributes"]["item_id"]).to eq(@invoice_items_1.item.id)
      expect(ii_data["data"][0]["attributes"]["quantity"]).to eq(@invoice_items_1.quantity)
      unit_price = sprintf('%.2f', (@invoice_items_1.unit_price/100.0))
      expect(ii_data["data"][0]["attributes"]["unit_price"]).to eq(unit_price)

      expect(ii_data["data"][1]["id"]).to eq(@invoice_items_2.id.to_s)
      expect(ii_data["data"][1]["type"]).to eq("invoice_item")
      expect(ii_data["data"][1]["attributes"]["id"]).to eq(@invoice_items_2.id)
      expect(ii_data["data"][1]["attributes"]["item_id"]).to eq(@invoice_items_2.item.id)
      expect(ii_data["data"][1]["attributes"]["quantity"]).to eq(@invoice_items_2.quantity)
      unit_price = sprintf('%.2f', (@invoice_items_2.unit_price/100.0))
      expect(ii_data["data"][1]["attributes"]["unit_price"]).to eq(unit_price)
    end

    it 'can find all by quantity' do
      get "/api/v1/invoice_items/find_all?quantity=#{@invoice_items_2.quantity}"

      expect(response).to be_successful

      ii_data = JSON.parse(response.body)

      expect(ii_data.length).to eq(1)
      expect(ii_data["data"].length).to eq(2)

      expect(ii_data["data"][0]["id"]).to eq(@invoice_items_2.id.to_s)
      expect(ii_data["data"][0]["type"]).to eq("invoice_item")
      expect(ii_data["data"][0]["attributes"]["id"]).to eq(@invoice_items_2.id)
      expect(ii_data["data"][0]["attributes"]["item_id"]).to eq(@invoice_items_2.item.id)
      expect(ii_data["data"][0]["attributes"]["quantity"]).to eq(@invoice_items_2.quantity)
      unit_price = sprintf('%.2f', (@invoice_items_2.unit_price/100.0))
      expect(ii_data["data"][0]["attributes"]["unit_price"]).to eq(unit_price)

      expect(ii_data["data"][1]["id"]).to eq(@invoice_items_5.id.to_s)
      expect(ii_data["data"][1]["type"]).to eq("invoice_item")
      expect(ii_data["data"][1]["attributes"]["id"]).to eq(@invoice_items_5.id)
      expect(ii_data["data"][1]["attributes"]["item_id"]).to eq(@invoice_items_5.item.id)
      expect(ii_data["data"][1]["attributes"]["quantity"]).to eq(@invoice_items_5.quantity)
      unit_price = sprintf('%.2f', (@invoice_items_5.unit_price/100.0))
      expect(ii_data["data"][1]["attributes"]["unit_price"]).to eq(unit_price)
    end

    it 'can find all by unit price' do
      unit_price = sprintf('%.2f', (@invoice_items_2.unit_price/100.0))
      get "/api/v1/invoice_items/find_all?unit_price=#{unit_price}"

      expect(response).to be_successful

      ii_data = JSON.parse(response.body)

      expect(ii_data.length).to eq(1)
      expect(ii_data["data"].length).to eq(2)

      expect(ii_data["data"][0]["id"]).to eq(@invoice_items_2.id.to_s)
      expect(ii_data["data"][0]["type"]).to eq("invoice_item")
      expect(ii_data["data"][0]["attributes"]["id"]).to eq(@invoice_items_2.id)
      expect(ii_data["data"][0]["attributes"]["item_id"]).to eq(@invoice_items_2.item.id)
      expect(ii_data["data"][0]["attributes"]["quantity"]).to eq(@invoice_items_2.quantity)
      unit_price = sprintf('%.2f', (@invoice_items_2.unit_price/100.0))
      expect(ii_data["data"][0]["attributes"]["unit_price"]).to eq(unit_price)

      expect(ii_data["data"][1]["id"]).to eq(@invoice_items_4.id.to_s)
      expect(ii_data["data"][1]["type"]).to eq("invoice_item")
      expect(ii_data["data"][1]["attributes"]["id"]).to eq(@invoice_items_4.id)
      expect(ii_data["data"][1]["attributes"]["item_id"]).to eq(@invoice_items_4.item.id)
      expect(ii_data["data"][1]["attributes"]["quantity"]).to eq(@invoice_items_4.quantity)
      unit_price = sprintf('%.2f', (@invoice_items_4.unit_price/100.0))
      expect(ii_data["data"][1]["attributes"]["unit_price"]).to eq(unit_price)
    end

  end

  it 'can return a random invoice_item' do
    create_list(:invoice_item, 5)

    get "/api/v1/invoice_items/random.json"

    expect(response).to be_successful

    ii_data = JSON.parse(response.body)

    expect(ii_data.length).to eq(1)
    expect(ii_data["data"].length).to eq(3)
    expect(ii_data["data"].keys). to eq(["id", "type", "attributes"])
    expect(ii_data["data"]["type"]). to eq("invoice_item")
    expect(ii_data["data"]["attributes"].keys). to eq(["id", "item_id", "invoice_id", "quantity", "unit_price"])
  end
end