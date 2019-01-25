class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity
  validates_presence_of :unit_price

  belongs_to :item
  belongs_to :invoice

  def self.by_date(date)
    InvoiceItem.joins(invoice: :transactions)
                        .where("invoices.updated_at >= '#{date}' AND invoices.updated_at < '#{date}'::date + '1 day'::interval")
                        .where(transactions: {result: 0})
                        .sum("invoice_items.unit_price * invoice_items.quantity")
  end
end
