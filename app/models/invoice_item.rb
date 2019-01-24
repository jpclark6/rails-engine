class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity
  validates_presence_of :unit_price

  belongs_to :item
  belongs_to :invoice

  def self.by_date(date)
    revenue = select("sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
        .joins(invoice: :transactions)
        .where("transactions.updated_at >= '#{date}' AND transactions.updated_at < '#{date}'::date + '1 day'::interval")
        .where(transactions: {result: 0})
        .group("transactions.updated_at")[0]
    if revenue
      return revenue
    else
      return {total_revenue: 0}
    end
  end
end
