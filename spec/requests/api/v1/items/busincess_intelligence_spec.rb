require 'rails_helper'

describe 'item API' do
  before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)
      @merchant_4 = create(:merchant)

      @item_1 = create(:item, merchant: @merchant_1, unit_price: 250)
      @item_2 = create(:item, merchant: @merchant_1, unit_price: 1000)
      @item_3 = create(:item, merchant: @merchant_2, unit_price: 3000)
      @item_4 = create(:item, merchant: @merchant_3, unit_price: 4000)
      @item_5 = create(:item, merchant: @merchant_4, unit_price: 5000)

      @invoice_1 = create(:invoice, merchant: @merchant_1, status: "shipped", updated_at: '2012-03-20 14:54:09 UTC')
      @invoice_2 = create(:invoice, merchant: @merchant_1, status: "shipped", updated_at: '2012-03-21 14:54:09 UTC')
      @invoice_3 = create(:invoice, merchant: @merchant_2, status: "shipped", updated_at: '2012-03-24 14:54:09 UTC')
      @invoice_4 = create(:invoice, merchant: @merchant_3, status: "shipped", updated_at: '2012-03-24 14:54:09 UTC')
      @invoice_5 = create(:invoice, merchant: @merchant_4, status: "shipped", updated_at: '2012-03-24 14:54:09 UTC')

      @invoice_items_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 11, unit_price: 250)  #20 #1 2,500  5,000
      @invoice_items_2 = create(:invoice_item, item: @item_2, invoice: @invoice_1, quantity: 10, unit_price: 1000) #20 #2 10,000 20,000
      @invoice_items_3 = create(:invoice_item, item: @item_1, invoice: @invoice_2, quantity: 10, unit_price: 250)  #10 #1 2,500
      @invoice_items_4 = create(:invoice_item, item: @item_2, invoice: @invoice_2, quantity: 10, unit_price: 1000) #10 #2 10,000
      @invoice_items_5 = create(:invoice_item, item: @item_3, invoice: @invoice_3, quantity: 14, unit_price: 3000) #10 #3 30,000 30,000
      @invoice_items_7 = create(:invoice_item, item: @item_4, invoice: @invoice_4, quantity: 11, unit_price: 4000) #11 #4 44,000 44,000
      @invoice_items_8 = create(:invoice_item, item: @item_5, invoice: @invoice_5, quantity: 100, unit_price: 5000)#5 500,000

      @transaction_1 = create(:transaction, invoice: @invoice_1, result: :success, updated_at: '2012-03-20 14:54:09 UTC')
      @transaction_2 = create(:transaction, invoice: @invoice_2, result: :success, updated_at: '2012-03-21 14:54:09 UTC')
      @transaction_3 = create(:transaction, invoice: @invoice_3, result: :success, updated_at: '2012-03-24 14:54:09 UTC')
      @transaction_4 = create(:transaction, invoice: @invoice_4, result: :success, updated_at: '2012-03-24 14:54:09 UTC')
      @transaction_5 = create(:transaction, invoice: @invoice_5, result: :failed, updated_at: '2012-03-24 14:54:09 UTC')
  end
  it 'can find top items by most revenue' do
    get "/api/v1/items/most_revenue?quantity=2"

    expect(response).to be_successful
    items_data = JSON.parse(response.body)

    #item 4, item 3

    expect(items_data["data"].length).to eq(2)
    expect(items_data["data"][0]["attributes"]["id"]).to eq(@item_4.id)
    expect(items_data["data"][0]["attributes"]["name"]).to eq(@item_4.name)
    expect(items_data["data"][0]["attributes"]["description"]).to eq(@item_4.description)
    unit_price = sprintf('%.2f', (@invoice_items_7.unit_price/100.0))
    expect(items_data["data"][0]["attributes"]["unit_price"]).to eq(unit_price)
    expect(items_data["data"][0]["attributes"]["merchant_id"]).to eq(@item_4.merchant_id)
    expect(items_data["data"][0]["type"]).to eq("item")

    expect(items_data["data"][1]["attributes"]["id"]).to eq(@item_3.id)
    expect(items_data["data"][1]["attributes"]["name"]).to eq(@item_3.name)
    expect(items_data["data"][1]["attributes"]["description"]).to eq(@item_3.description)
    unit_price = sprintf('%.2f', (@invoice_items_5.unit_price/100.0))
    expect(items_data["data"][1]["attributes"]["unit_price"]).to eq(unit_price)
    expect(items_data["data"][1]["attributes"]["merchant_id"]).to eq(@item_3.merchant_id)
    expect(items_data["data"][1]["type"]).to eq("item")
  end
  it 'can find most items sold' do
    #item 1, item 2
    get "/api/v1/items/most_items?quantity=2"

    expect(response).to be_successful
    items_data = JSON.parse(response.body)

    expect(items_data["data"].length).to eq(2)
    expect(items_data["data"][0]["attributes"]["id"]).to eq(@item_1.id)
    expect(items_data["data"][0]["attributes"]["name"]).to eq(@item_1.name)
    expect(items_data["data"][0]["attributes"]["description"]).to eq(@item_1.description)
    unit_price = sprintf('%.2f', (@item_1.unit_price/100.0))
    expect(items_data["data"][0]["attributes"]["unit_price"]).to eq(unit_price)
    expect(items_data["data"][0]["attributes"]["merchant_id"]).to eq(@item_1.merchant_id)
    expect(items_data["data"][0]["type"]).to eq("item")

    expect(items_data["data"][1]["attributes"]["id"]).to eq(@item_2.id)
    expect(items_data["data"][1]["attributes"]["name"]).to eq(@item_2.name)
    expect(items_data["data"][1]["attributes"]["description"]).to eq(@item_2.description)
    unit_price = sprintf('%.2f', (@item_2.unit_price/100.0))
    expect(items_data["data"][1]["attributes"]["unit_price"]).to eq(unit_price)
    expect(items_data["data"][1]["attributes"]["merchant_id"]).to eq(@item_2.merchant_id)
    expect(items_data["data"][1]["type"]).to eq("item")
  end
  it 'can find the best day' do
    get "/api/v1/items/#{@item_1.id}/best_day"

    expect(response).to be_successful
    items_data = JSON.parse(response.body)

    expect(items_data["data"]["attributes"]["best_day"]).to eq('2012-03-20T14:54:09.000Z')
  end
end
