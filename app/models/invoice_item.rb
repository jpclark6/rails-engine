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

  def self.find_invoice_item_by(params)
    if params.keys.index("id")
      invoice_item = InvoiceItem.find_by_id(params["id"])
    elsif params.keys.index("item_id")
      invoice_item = InvoiceItem.where("item_id = ?", params["item_id"]).first
    elsif params.keys.index("invoice_id")
      invoice_item = InvoiceItem.where("invoice_id = ?", params["invoice_id"]).first
    elsif params.keys.index("quantity")
      invoice_item = InvoiceItem.where("quantity = ?", params["quantity"]).first
    elsif params.keys.index("unit_price")
      unit_price = (params["unit_price"].to_f * 100).to_i
      invoice_item = InvoiceItem.where("unit_price = ?", unit_price).first
    elsif params.keys.index("updated_at")
      invoice_item = InvoiceItem.where(updated_at: params["updated_at"]).first
    elsif params.keys.index("created_at")
      invoice_item = InvoiceItem.where(created_at: params["created_at"]).first
    end
    invoice_item
  end
end
