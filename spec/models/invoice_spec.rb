require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer)}
    it { should belong_to(:merchant)}
    it { should have_many(:transactions) } 
    it { should have_many(:invoice_items) } 
    it { should have_many(:items).through(:invoice_items) } 
  end
  describe 'validations' do
    it { should validate_presence_of(:status) }
  end
  describe 'class methods' do
    it '.find_invoice_by' do
      create_list(:invoice, 3)

      invoice = Invoice.find_invoice_by(params = {"id" => Invoice.second.id})
      expect(invoice).to eq(Invoice.second)
      
      invoice = Invoice.find_invoice_by(params = {"customer_id" => Invoice.second.customer_id})
      expect(invoice).to eq(Invoice.second)
      
      invoice = Invoice.find_invoice_by(params = {"merchant_id" => Invoice.second.merchant_id})
      expect(invoice).to eq(Invoice.second)

      invoice = Invoice.find_invoice_by(params = {"status" => Invoice.second.status})
      expect(invoice).to eq(Invoice.first)

      invoice = Invoice.find_invoice_by(params = {"created_at" => Invoice.second.created_at})
      expect(invoice).to eq(Invoice.second)

      invoice = Invoice.find_invoice_by(params = {"updated_at" => Invoice.second.updated_at})
      expect(invoice).to eq(Invoice.second)
    end
    it '.find_invoices_by' do
      customer_1 = create(:customer)
      customer_2 = create(:customer)

      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      invoice_1 = create(:invoice, customer: customer_1, merchant: merchant_1, status: "shipped", created_at: '2019-01-01', updated_at: '2019-01-03')
      invoice_2 = create(:invoice, customer: customer_1, merchant: merchant_2, status: "shipped", created_at: '2019-01-01', updated_at: '2019-01-03')
      invoice_3 = create(:invoice, customer: customer_2, merchant: merchant_1, status: "shipped", created_at: '2019-01-02', updated_at: '2019-01-04')
      invoice_4 = create(:invoice, customer: customer_2, merchant: merchant_2, status: "shipped", created_at: '2019-01-02', updated_at: '2019-01-04')

      invoices = Invoice.find_invoices_by(params = {"id" => Invoice.second.id})
      expect(invoices).to eq([Invoice.second])
      
      invoices = Invoice.find_invoices_by(params = {"customer_id" => Invoice.second.customer_id})
      expect(invoices).to eq([invoice_1, invoice_2])
      
      invoices = Invoice.find_invoices_by(params = {"merchant_id" => Invoice.second.merchant_id})
      expect(invoices).to eq([invoice_2, invoice_4])

      invoices = Invoice.find_invoices_by(params = {"status" => Invoice.second.status})
      expect(invoices).to eq([invoice_1, invoice_2, invoice_3, invoice_4])

      invoices = Invoice.find_invoices_by(params = {"created_at" => Invoice.second.created_at})
      expect(invoices).to eq([invoice_1, invoice_2])

      invoices = Invoice.find_invoices_by(params = {"updated_at" => Invoice.second.updated_at})
      expect(invoices).to eq([invoice_1, invoice_2])
    end
  end
end