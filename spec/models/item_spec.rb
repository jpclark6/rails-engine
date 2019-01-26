require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should have_many(:invoice_items)}
    it { should have_many(:invoices).through(:invoice_items)}
    it { should belong_to(:merchant)}
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end
  describe 'class methods' do
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

      @invoice_items_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 11, unit_price: 250)
      @invoice_items_2 = create(:invoice_item, item: @item_2, invoice: @invoice_1, quantity: 10, unit_price: 1000)
      @invoice_items_3 = create(:invoice_item, item: @item_1, invoice: @invoice_2, quantity: 10, unit_price: 250)
      @invoice_items_4 = create(:invoice_item, item: @item_2, invoice: @invoice_2, quantity: 10, unit_price: 1000)
      @invoice_items_5 = create(:invoice_item, item: @item_3, invoice: @invoice_3, quantity: 14, unit_price: 3000)
      @invoice_items_7 = create(:invoice_item, item: @item_4, invoice: @invoice_4, quantity: 11, unit_price: 4000)
      @invoice_items_8 = create(:invoice_item, item: @item_5, invoice: @invoice_5, quantity: 100, unit_price: 5000)

      @transaction_1 = create(:transaction, invoice: @invoice_1, result: :success, updated_at: '2012-03-20 14:54:09 UTC')
      @transaction_2 = create(:transaction, invoice: @invoice_2, result: :success, updated_at: '2012-03-21 14:54:09 UTC')
      @transaction_3 = create(:transaction, invoice: @invoice_3, result: :success, updated_at: '2012-03-24 14:54:09 UTC')
      @transaction_4 = create(:transaction, invoice: @invoice_4, result: :success, updated_at: '2012-03-24 14:54:09 UTC')
      @transaction_5 = create(:transaction, invoice: @invoice_5, result: :failed, updated_at: '2012-03-24 14:54:09 UTC')
    end
    it '.top_revenue' do
      expect(Item.top_revenue(2)).to eq([@item_4, @item_3])
      expect(Item.top_revenue(1)).to eq([@item_4])
    end
    it '.most_sold' do
      expect(Item.most_sold(2)).to eq([@item_1, @item_2])
      expect(Item.most_sold(1)).to eq([@item_1])
    end
  end
  describe 'instance methods' do
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

      @invoice_items_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 11, unit_price: 250)
      @invoice_items_2 = create(:invoice_item, item: @item_2, invoice: @invoice_1, quantity: 10, unit_price: 1000)
      @invoice_items_3 = create(:invoice_item, item: @item_1, invoice: @invoice_2, quantity: 10, unit_price: 250)
      @invoice_items_4 = create(:invoice_item, item: @item_2, invoice: @invoice_2, quantity: 10, unit_price: 1000)
      @invoice_items_5 = create(:invoice_item, item: @item_3, invoice: @invoice_3, quantity: 14, unit_price: 3000)
      @invoice_items_7 = create(:invoice_item, item: @item_4, invoice: @invoice_4, quantity: 11, unit_price: 4000)
      @invoice_items_8 = create(:invoice_item, item: @item_5, invoice: @invoice_5, quantity: 100, unit_price: 5000)

      @transaction_1 = create(:transaction, invoice: @invoice_1, result: :success, updated_at: '2012-03-20 14:54:09 UTC')
      @transaction_2 = create(:transaction, invoice: @invoice_2, result: :success, updated_at: '2012-03-21 14:54:09 UTC')
      @transaction_3 = create(:transaction, invoice: @invoice_3, result: :success, updated_at: '2012-03-24 14:54:09 UTC')
      @transaction_4 = create(:transaction, invoice: @invoice_4, result: :success, updated_at: '2012-03-24 14:54:09 UTC')
      @transaction_5 = create(:transaction, invoice: @invoice_5, result: :failed, updated_at: '2012-03-24 14:54:09 UTC')
    end
    it '.best_day' do
      expect(@item_1.best_day).to eq('2012-03-20T14:54:09.000Z')
    end

  end
end
