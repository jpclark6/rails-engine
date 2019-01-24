require 'rails_helper'
include ActionView::Helpers::NumberHelper

describe 'requesting a merchant' do
  describe 'all merchants' do
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
      @invoice_3 = create(:invoice, merchant: @merchant_2, status: "shipped", updated_at: '2012-03-22 14:54:09 UTC')
      @invoice_4 = create(:invoice, merchant: @merchant_3, status: "shipped", updated_at: '2012-03-23 14:54:09 UTC')
      @invoice_5 = create(:invoice, merchant: @merchant_4, status: "shipped", updated_at: '2012-03-24 14:54:09 UTC')

      @invoice_items_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 10, unit_price: @item_1.unit_price)
      @invoice_items_2 = create(:invoice_item, item: @item_2, invoice: @invoice_1, quantity: 10, unit_price: @item_2.unit_price)
      @invoice_items_3 = create(:invoice_item, item: @item_1, invoice: @invoice_2, quantity: 10, unit_price: @item_1.unit_price)
      @invoice_items_4 = create(:invoice_item, item: @item_2, invoice: @invoice_2, quantity: 10, unit_price: @item_2.unit_price)
      @invoice_items_5 = create(:invoice_item, item: @item_3, invoice: @invoice_3, quantity: 10, unit_price: @item_3.unit_price)
      @invoice_items_7 = create(:invoice_item, item: @item_4, invoice: @invoice_4, quantity: 10, unit_price: @item_4.unit_price)
      @invoice_items_8 = create(:invoice_item, item: @item_5, invoice: @invoice_5, quantity: 100, unit_price: @item_5.unit_price)

      @transaction_1 = create(:transaction, invoice: @invoice_1, result: :success, updated_at: '2012-03-20 14:54:09 UTC')
      @transaction_2 = create(:transaction, invoice: @invoice_2, result: :success, updated_at: '2012-03-21 14:54:09 UTC')
      @transaction_3 = create(:transaction, invoice: @invoice_3, result: :success, updated_at: '2012-03-22 14:54:09 UTC')
      @transaction_4 = create(:transaction, invoice: @invoice_4, result: :success, updated_at: '2012-03-23 14:54:09 UTC')
      @transaction_5 = create(:transaction, invoice: @invoice_5, result: :failed, updated_at: '2012-03-24 14:54:09 UTC')
    end
    
    it 'returns a selected quantity of top merchants by revenue' do
      get "/api/v1/merchants/most_revenue?quantity=2"
      
      expect(response).to be_successful
      merchants_data = JSON.parse(response.body)

      ex_rev_1 = number_to_currency(Merchant.top_revenue(2)[0].total_revenue / 100.0)[1..-1]
      ex_rev_2 = number_to_currency(Merchant.top_revenue(2)[1].total_revenue / 100.0)[1..-1]

      expect(merchants_data["data"].length).to eq(2)
      expect(merchants_data["data"][0]["attributes"]["name"]).to eq(@merchant_3.name)
      expect(merchants_data["data"][0]["attributes"]["total_revenue"]).to eq(ex_rev_1)
      expect(merchants_data["data"][0]["type"]).to eq("merchants_revenue")
      expect(merchants_data["data"][1]["attributes"]["name"]).to eq(@merchant_2.name)
      expect(merchants_data["data"][1]["attributes"]["total_revenue"]).to eq(ex_rev_2)
      expect(merchants_data["data"][1]["type"]).to eq("merchants_revenue")
      # @merchant_3, @merchant_2
    end
    xit 'can find merchants with the most items sold with qty to return' do
      get "/api/v1/merchants/most_items?quantity=3"

      expect(response).to be_successful
      merchants_data = JSON.parse(response.body)
    end
    xit 'can find total revenue on a given date for all merchants' do
      get "/api/v1/merchants/revenue?date=x"

      expect(response).to be_successful
      merchants_data = JSON.parse(response.body)
    end

   

    # NOTE: Failed charges should never be counted in revenue totals or statistics.

    # NOTE: All revenues should be reported as a float with two decimal places.

  end
  describe 'a single merchant' do

    # GET /api/v1/merchants/:id/revenue
    # GET /api/v1/merchants/:id/revenue?date=x
    # GET /api/v1/merchants/:id/favorite_customer
    # GET /api/v1/merchants/:id/customers_with_pending_invoices

  end

end