class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def self.top_revenue(quantity)
    Item.select('items.*, (sum(invoice_items.unit_price * invoice_items.quantity)) as revenue')
        .joins(:invoice_items)
        .joins(invoices: :transactions)
        .where(transactions: {result: 0})
        .group(:id)
        .limit(quantity)
        .order('revenue desc')
  end

  def self.most_sold(quantity)
    Item.select('items.*, count(invoice_items.quantity) as quantity_sold').joins(:invoice_items).joins(invoices: :transactions).where(transactions: {result: 0}).group(:id).limit(quantity).reorder('quantity_sold desc')
  end

  def best_day
    time = Invoice.select('invoices.*, (invoice_items.unit_price * invoice_items.quantity) as revenue').joins(:invoice_items).joins(:transactions).where(transactions: {result: 0}).where('invoice_items.item_id = ?', id).order('revenue desc').first.updated_at
    time.strftime("%Y-%m-%dT%H:%M:%S.000Z")
  end

  # def revenue
  #   invoice_items.sum('invoice_items.unit_price * invoice_items.quantity')
  # end
end
