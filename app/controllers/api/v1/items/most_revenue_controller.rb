class Api::V1::Items::MostRevenueController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.top_revenue(params[:quantity]))
  end
end