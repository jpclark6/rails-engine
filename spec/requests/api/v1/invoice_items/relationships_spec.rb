require 'rails_helper'

describe 'as a customer' do
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

    @invoice_items_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 10, unit_price: @item_1.unit_price)
    @invoice_items_2 = create(:invoice_item, item: @item_2, invoice: @invoice_1, quantity: 10, unit_price: @item_2.unit_price)
    @invoice_items_3 = create(:invoice_item, item: @item_1, invoice: @invoice_2, quantity: 11, unit_price: @item_1.unit_price)
    @invoice_items_4 = create(:invoice_item, item: @item_2, invoice: @invoice_2, quantity: 10, unit_price: @item_2.unit_price)
    @invoice_items_5 = create(:invoice_item, item: @item_3, invoice: @invoice_3, quantity: 10, unit_price: @item_3.unit_price)
    @invoice_items_7 = create(:invoice_item, item: @item_4, invoice: @invoice_3, quantity: 11, unit_price: @item_4.unit_price)
    @invoice_items_8 = create(:invoice_item, item: @item_5, invoice: @invoice_4, quantity: 100, unit_price: @item_5.unit_price)
    @invoice_items_8 = create(:invoice_item, item: @item_5, invoice: @invoice_5, quantity: 100, unit_price: @item_5.unit_price)

    @transaction_1 = create(:transaction, invoice: @invoice_1, result: :success, updated_at: '2012-03-20 14:54:09 UTC')
    @transaction_2 = create(:transaction, invoice: @invoice_2, result: :success, updated_at: '2012-03-21 14:54:09 UTC')
    @transaction_3 = create(:transaction, invoice: @invoice_3, result: :success, updated_at: '2012-03-24 14:54:09 UTC')
    @transaction_4 = create(:transaction, invoice: @invoice_4, result: :success, updated_at: '2012-03-24 14:54:09 UTC')
    @transaction_5 = create(:transaction, invoice: @invoice_5, result: :failed, updated_at: '2012-03-24 14:54:09 UTC')
  end

  # GET /api/v1/invoice_items/:id/invoice returns the associated invoice
  # GET /api/v1/invoice_items/:id/item returns the associated item

end