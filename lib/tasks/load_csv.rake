desc 'Load CSV data for Rails Engine'

require 'csv'
require './config/environment.rb'

task :load_csv do
  CSV.foreach('./data/customers.csv', :headers => true, :header_converters => :symbol) do |row|
    Customer.create!(first_name: row[:first_name], last_name: row[:last_name], updated_at: row[:updated_at], created_at: row[:created_at])
  end
  CSV.foreach('./data/merchants.csv', :headers => true, :header_converters => :symbol) do |row|
    Merchant.create!(name: row[:name], updated_at: row[:updated_at], created_at: row[:created_at])
  end
  CSV.foreach('./data/items.csv', :headers => true, :header_converters => :symbol) do |row|
    Item.create!(name: row[:name], description: row[:description], unit_price: row[:unit_price], updated_at: row[:updated_at], created_at: row[:created_at], merchant: Merchant.find(row[:merchant_id]))
  end
  CSV.foreach('./data/invoices.csv', :headers => true, :header_converters => :symbol) do |row|
    Invoice.create!(customer: Customer.find(row[:customer_id]), merchant: Merchant.find(row[:merchant_id]), status: row[:status], updated_at: row[:updated_at], created_at: row[:created_at])
  end
  CSV.foreach('./data/invoice_items.csv', :headers => true, :header_converters => :symbol) do |row|
    InvoiceItem.create!(item: Item.find(row[:item_id]), invoice: Invoice.find(row[:invoice_id]), quantity: row[:quantity], unit_price: row[:unit_price], updated_at: row[:updated_at], created_at: row[:created_at])
  end
  CSV.foreach('./data/transactions.csv', :headers => true, :header_converters => :symbol) do |row|
    Transaction.create!(invoice: Invoice.find(row[:invoice_id]), credit_card_number: row[:credit_card_number], credit_card_expiration_date: row[:credit_card_expiration_date], result: row[:result].to_s, updated_at: row[:updated_at], created_at: row[:created_at])
  end
end