class Api::V1::CustomersController < ApplicationController
  def index
    render json: [data: Customer.all]
  end
end