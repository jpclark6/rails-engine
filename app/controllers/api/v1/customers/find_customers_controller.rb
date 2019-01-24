class Api::V1::Customers::FindCustomersController < ApplicationController
  def index
    customers = Customer.find_customers_by(params)
    render json: CustomerSerializer.new(customers) unless customers.empty?
  end

  def show
    customer = Customer.find_customer_by(params)
    render json: CustomerSerializer.new(customer) if customer
  end
end
