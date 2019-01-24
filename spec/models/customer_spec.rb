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
end
