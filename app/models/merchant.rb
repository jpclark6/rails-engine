class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices

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
      x = invoices.joins(:invoice_items)
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

end
