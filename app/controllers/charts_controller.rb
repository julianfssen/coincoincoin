class ChartsController < ApplicationController
  def show
    derivative_id = params[:id]
    data = DerivativeDailyHistoricalPrice.where(derivative_id: derivative_id).order(created_at: :desc).limit(7).pluck(:created_at, :price)
    data = data.collect { |date, price| [date.strftime('%b %d, %Y'), price] }
    render json: data
  end
end
