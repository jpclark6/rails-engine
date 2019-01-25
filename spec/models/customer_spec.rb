require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices)}
  end
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end
  describe 'class methods' do
    it '.find_customer_by' do
      create_list(:customer, 3)
      customer = Customer.find_customer_by(params = {"id" => Customer.second.id})
      expect(customer).to eq(Customer.second)
      customer = Customer.find_customer_by(params = {"id" => Customer.third.id})
      expect(customer).to eq(Customer.third)
      
      customer = Customer.find_customer_by(params = {"first_name" => Customer.second.first_name.upcase})
      expect(customer).to eq(Customer.second)
      
      customer = Customer.find_customer_by(params = {"last_name" => Customer.second.last_name.upcase})
      expect(customer).to eq(Customer.second)

      customer = Customer.find_customer_by(params = {"updated_at" => Customer.second.updated_at})
      expect(customer).to eq(Customer.second)

      customer = Customer.find_customer_by(params = {"created_at" => Customer.second.created_at})
      expect(customer).to eq(Customer.second)
    end
    it '.find_customers_by' do
      create(:customer, first_name: 'John', last_name: 'Elway', created_at: '2012-03-27 14:54:10 UTC', updated_at: '2013-05-27 14:54:10 UTC')
      create(:customer, first_name: 'John', last_name: 'Doe', created_at: '2012-03-27 14:54:10 UTC', updated_at: '2013-04-27 14:54:10 UTC')
      create(:customer, first_name: 'Elf', last_name: 'Doe', created_at: '2012-04-27 14:54:10 UTC', updated_at: '2013-03-27 14:54:10 UTC')
      create(:customer, first_name: 'Gandalf', last_name: 'The grey', created_at: '2012-05-27 14:54:10 UTC', updated_at: '2013-03-27 14:54:10 UTC')

      customer = Customer.find_customers_by(params = {"id" => Customer.second.id})
      expect(customer).to eq([Customer.second])

      customer = Customer.find_customers_by(params = {"id" => Customer.third.id})
      expect(customer).to eq([Customer.third])
      
      customer = Customer.find_customers_by(params = {"first_name" => Customer.first.first_name.upcase})
      expect(customer).to eq([Customer.first, Customer.second])
      
      customer = Customer.find_customers_by(params = {"last_name" => Customer.second.last_name.downcase})
      expect(customer).to eq([Customer.second, Customer.third])

      customer = Customer.find_customers_by(params = {"updated_at" => Customer.last.updated_at})
      expect(customer).to eq([Customer.third, Customer.last])

      customer = Customer.find_customers_by(params = {"created_at" => Customer.first.created_at})
      expect(customer).to eq([Customer.first, Customer.second])
    end
  end
  describe 'instance methods' do
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
    it '.all_transactions' do
      expect(@customer_1.all_transactions).to eq([@transaction_1, @transaction_4])
      expect(@customer_2.all_transactions).to eq([@transaction_2, @transaction_5])
    end
  end
end

