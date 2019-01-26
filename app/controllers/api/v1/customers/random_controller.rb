class Api::V1::Customers::RandomController < ApplicationController
  def show
    render json: CustomerSerializer.new(Customer.order("RANDOM()").first)
  end
end