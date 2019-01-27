class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def self.find_invoice_by(params)
    if params.keys.index("id")
      invoice = Invoice.find_by_id(params["id"])
    elsif params.keys.index("customer_id")
      invoice = Invoice.where("customer_id = ?", params["customer_id"]).first
    elsif params.keys.index("merchant_id")
      invoice = Invoice.where("merchant_id = ?", params["merchant_id"]).first
    elsif params.keys.index("status")
      invoice = Invoice.where("status = ?", params["status"]).first
    elsif params.keys.index("updated_at")
      invoice = Invoice.where(updated_at: params["updated_at"]).first
    elsif params.keys.index("created_at")
      invoice = Invoice.where(created_at: params["created_at"]).first
    end
    invoice
  end

  def self.find_invoices_by(params)
    if params.keys.index("id")
      invoices = [Invoice.find_by_id(params["id"])]
    elsif params.keys.index("customer_id")
      invoices = Invoice.where("customer_id = ?", params["customer_id"])
    elsif params.keys.index("merchant_id")
      invoices = Invoice.where("merchant_id = ?", params["merchant_id"])
    elsif params.keys.index("status")
      invoices = Invoice.where("status = ?", params["status"])
    elsif params.keys.index("updated_at")
      invoices = Invoice.where(updated_at: params["updated_at"])
    elsif params.keys.index("created_at")
      invoices = Invoice.where(created_at: params["created_at"])
    end
    invoices
  end
end
