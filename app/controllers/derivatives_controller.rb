class DerivativesController < ApplicationController
  CONTRACT_TYPES = ['Any', 'Futures', 'Perpetual']

  def index
    @derivative_exchanges = DerivativeExchange.all.order(:name)
    @contract_types = CONTRACT_TYPES
    @contract_type = 'any'
    filters = params[:filters]
    if filters
      @derivative_exchange_id = filters[:derivative_exchange_id].to_i
      @contract_type = filters[:contract_type].downcase
    else
      @derivative_exchange_id = DerivativeExchange.find(1).id
    end
    @sort = params[:sort]
    @derivatives = Derivative.where(derivative_exchange_id: @derivative_exchange_id)
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
    @derivatives = @derivatives.where(contract_type: @contract_type) unless @contract_type.eql? 'any'
  end

  def show
  end
end
