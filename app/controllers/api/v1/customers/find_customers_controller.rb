class Api::V1::Customers::FindCustomersController < ApplicationController
  def show
    if params.keys.index("id")
      id = params[:id]
    elsif params.keys.index("first_name")
      id = Customer.where("lower(first_name) = ?", params[:first_name].downcase).first.id
    elsif params.keys.index("last_name")
      id = Customer.where("lower(last_name) = ?", params[:last_name].downcase).first.id
    elsif params.keys.index("updated_at")
      id = Customer.where(updated_at: params[:updated_at]).first.id
    elsif params.keys.index("created_at")
      id = Customer.where(created_at: params[:created_at]).first.id
    end
    render json: CustomerSerializer.new(Customer.find(id))
  end
end
