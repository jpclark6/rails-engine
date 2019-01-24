class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name
  
  has_many :invoices

  def self.find_customers_by(params)
    if params.keys.index("id")
      customers = Customer.find_by(id: params["id"]) ? [Customer.find_by(id: params["id"])] : []
    elsif params.keys.index("first_name")
      customers = Customer.where("lower(first_name) = ?", params["first_name"].downcase)
    elsif params.keys.index("last_name")
      customers = Customer.where("lower(last_name) = ?", params["last_name"].downcase)
    elsif params.keys.index("updated_at")
      customers = Customer.where(updated_at: params["updated_at"])
    elsif params.keys.index("created_at")
      customers = Customer.where(created_at: params["created_at"])
    end
    customers
  end

  def self.find_customer_by(params)
    if params.keys.index("id")
      customer = Customer.find_by_id(params["id"])
    elsif params.keys.index("first_name")
      customer = Customer.where("lower(first_name) = ?", params["first_name"].downcase).first
    elsif params.keys.index("last_name")
      customer = Customer.where("lower(last_name) = ?", params["last_name"].downcase).first
    elsif params.keys.index("updated_at")
      customer = Customer.where(updated_at: params["updated_at"]).first
    elsif params.keys.index("created_at")
      customer = Customer.where(created_at: params["created_at"]).first
    end
    customer
  end
end

