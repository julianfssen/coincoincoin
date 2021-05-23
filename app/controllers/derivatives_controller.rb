class DerivativesController < ApplicationController
  def index
    @derivative_exchanges = DerivativeExchange.all.order(:name)
    @derivative_exchange_id = params[:derivative_exchange_id] || DerivativeExchange.find(1).id
    @sort = params[:sort]
    @contract_type = params[:contract_type]
    @derivatives = Derivative.where(market_id: @derivative_exchange_id)
    case @sort
    when 'volume_asc'
      @derivatives = @derivatives.by_volume_24h_asc.limit(10)
    when 'price_asc'
      @derivatives = @derivatives.by_price_asc.limit(10)
    when 'price_desc'
      @derivatives = @derivatives.by_price_desc.limit(10)
    when 'ticker_asc'
      @derivatives = @derivatives.by_symbol_asc.limit(10)
    when 'ticker_desc'
      @derivatives = @derivatives.by_symbol_desc.limit(10)
    when 'price_percentage_change_24h_asc'
      @derivatives = @derivatives.by_price_percentage_change_24h_asc.limit(10)
    when 'price_percentage_change_24h_desc'
      @derivatives = @derivatives.by_price_percentage_change_24h_desc.limit(10)
    else
      @derivatives = @derivatives.by_volume_24h_desc.limit(10)
    end
    @derivatives = @derivatives.where(contract_type: @contract_type) if @contract_type
  end

  def show
  end
end
