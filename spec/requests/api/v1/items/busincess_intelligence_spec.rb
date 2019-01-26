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

      @invoice_items_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 10, unit_price: 250)
      @invoice_items_2 = create(:invoice_item, item: @item_2, invoice: @invoice_1, quantity: 10, unit_price: 1000)
      @invoice_items_3 = create(:invoice_item, item: @item_1, invoice: @invoice_2, quantity: 10, unit_price: 250)
      @invoice_items_4 = create(:invoice_item, item: @item_2, invoice: @invoice_2, quantity: 10, unit_price: 1000)
      @invoice_items_5 = create(:invoice_item, item: @item_3, invoice: @invoice_3, quantity: 10, unit_price: 3000)
      @invoice_items_7 = create(:invoice_item, item: @item_4, invoice: @invoice_4, quantity: 11, unit_price: 4000)
      @invoice_items_8 = create(:invoice_item, item: @item_5, invoice: @invoice_5, quantity: 100, unit_price: 5000)

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

    # expect(merchants_data["data"].length).to eq(2)
    # expect(merchants_data["data"][0]["attributes"]["id"]).to eq(@merchant_3.id)
    # expect(merchants_data["data"][0]["attributes"]["name"]).to eq(@merchant_3.name)
    # expect(merchants_data["data"][0]["attributes"]["revenue"]).to eq(ex_rev_1)
    # expect(merchants_data["data"][0]["type"]).to eq("merchants_revenue")
    # expect(merchants_data["data"][1]["attributes"]["id"]).to eq(@merchant_2.id)
    # expect(merchants_data["data"][1]["attributes"]["name"]).to eq(@merchant_2.name)
    # expect(merchants_data["data"][1]["attributes"]["revenue"]).to eq(ex_rev_2)
    # expect(merchants_data["data"][1]["type"]).to eq("merchants_revenue")
  end
  it 'can find most items sold' do

  end
  it 'can find the best day' do

  end
end

# GET /api/v1/items/most_revenue?quantity=x returns the top x items ranked by total revenue generated

# GET /api/v1/items/most_items?quantity=x returns the top x item instances ranked by total number sold

# GET /api/v1/items/:id/best_day returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day.
