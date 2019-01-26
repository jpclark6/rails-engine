class Api::V1::Items::BestDayController < ApplicationController
  def show
    day = Struct.new(:id, :best_day)
    best_day = day.new(1, Item.find(params[:id]).best_day)
    render json: BestDaySerializer.new(best_day)
  end
end