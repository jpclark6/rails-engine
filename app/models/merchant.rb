class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items

  def self.top_revenue(quantity)
    Merchant.select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
            .joins(invoices: :invoice_items)
            .joins(invoices: :transactions)
            .where(transactions: {result: 0})
            .group(:id)
            .order("revenue desc")
            .limit(quantity)
  end

  def self.top_items(quantity)
    Merchant.select('merchants.*, sum(invoice_items.quantity) as total_items')
            .joins(invoices: :invoice_items)
            .joins(invoices: :transactions)
            .where(transactions: {result: 0})
            .group(:id)
            .order("total_items desc")
            .limit(quantity)
  end

  def total_revenue(params)
    if params.keys.include?("date")
      date = params[:date]
      invoices.joins(:invoice_items)
          .joins(:transactions)
          .where(transactions: {result: 0})
          .where("invoices.updated_at >= '#{date}' AND invoices.updated_at < '#{date}'::date + '1 day'::interval")
          .sum('invoice_items.quantity * invoice_items.unit_price')
    else
      invoices.joins(:invoice_items)
          .joins(:transactions)
          .where(transactions: {result: 0})
          .sum('invoice_items.quantity * invoice_items.unit_price')
    end
  end

  def favorite_customer
    customer = invoices.select('customer_id, count(transactions.id) as trans_count')
            .joins(:transactions)
            .where(transactions: {result: 0})
            .group(:customer_id)
            .order('trans_count desc')[0]
    Customer.find(customer.customer_id)
  end

  def self.find_merchant_by(params)
    if params.keys.index("id")
      merchant = Merchant.find_by_id(params["id"])
    elsif params.keys.index("name")
      merchant = Merchant.where("name = ?", params["name"]).first
    elsif params.keys.index("updated_at")
      merchant = Merchant.where(updated_at: params["updated_at"]).first
    elsif params.keys.index("created_at")
      merchant = Merchant.where(created_at: params["created_at"]).first
    end
    merchant
  end

  def self.find_merchants_by(params)
    if params.keys.index("id")
      merchants = [Merchant.find_by_id(params["id"])]
    elsif params.keys.index("name")
      merchants = Merchant.where("name = ?", params["name"])
    elsif params.keys.index("updated_at")
      merchants = Merchant.where(updated_at: params["updated_at"])
    elsif params.keys.index("created_at")
      merchants = Merchant.where(created_at: params["created_at"])
    end
    merchants
  end

  def customers_with_pending_invoices
    merchant_customers = Customer.joins(invoices: :transactions).select('customers.*').where("transactions.result = 1").where('invoices.merchant_id = ?', id).distinct
    merchant_customers.select do |customer|
      Transaction.joins(:invoice).where('invoices.merchant_id = ?', id).where("transactions.result = 0").where('invoices.customer_id = ?', customer.id).empty?
    end
  end
end
