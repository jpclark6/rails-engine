class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices

  def self.top_revenue(quantity)
    Merchant.select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue')
            .joins(invoices: :invoice_items)
            .joins(invoices: :transactions)
            .where(transactions: {result: 0})
            .group(:id)
            .order("total_revenue desc")
            .limit(quantity)
  end
end
