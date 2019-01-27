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
    time = Invoice.select('invoices.*, (sum(invoice_items.unit_price * invoice_items.quantity)) as revenue')
                  .joins(:invoice_items)
                  .joins(:transactions)
                  .where(transactions: {result: 0})
                  .where('invoice_items.item_id = ?', id)
                  .group('invoices.created_at')
                  .order('created_at desc')
                  .order('revenue desc')
                  .first
                  .updated_at

    time.strftime("%Y-%m-%dT%H:%M:%S.000Z")
  end
                
  def self.find_item_by(params)
    if params.keys.index("id")
      item = Item.find_by_id(params["id"])
    elsif params.keys.index("name")
      item = Item.where("name = ?", params["name"]).first
    elsif params.keys.index("description")
      item = Item.where("description = ?", params["description"]).first
    elsif params.keys.index("merchant_id")
      item = Item.where("merchant_id = ?", params["merchant_id"]).first
    elsif params.keys.index("unit_price")
      unit_price = (params["unit_price"].to_f * 100).round
      item = Item.where("unit_price = ?", unit_price).first
    elsif params.keys.index("updated_at")
      item = Item.where(updated_at: params["updated_at"]).first
    elsif params.keys.index("created_at")
      item = Item.where(created_at: params["created_at"]).first
    end
    item
  end

  def self.find_items_by(params)
    if params.keys.index("id")
      items = [Item.find_by_id(params["id"])]
    elsif params.keys.index("name")
      items = Item.where("name = ?", params["name"])
    elsif params.keys.index("description")
      items = Item.where("description = ?", params["description"])
    elsif params.keys.index("merchant_id")
      items = Item.where("merchant_id = ?", params["merchant_id"])
    elsif params.keys.index("unit_price")
      unit_price = (params["unit_price"].to_f * 100).round
      items = Item.where("unit_price = ?", unit_price)
    elsif params.keys.index("updated_at")
      items = Item.where(updated_at: params["updated_at"])
    elsif params.keys.index("created_at")
      items = Item.where(created_at: params["created_at"])
    end
    items
  end
end
