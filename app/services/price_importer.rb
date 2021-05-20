class PriceImporter
  include CoingeckoRuby

  def initialize
    @client = CoingeckoRuby.client
  end

  def import_daily_historical_prices_for_market(market_id:)
    response = @client.client.get_derivative_exchange(id: market_id, options: { include_tickers: true })
    tickers = response[:tickers]
    tickers.each do |ticker|
      derivative = Derivative.find_or_initialize_by(symbol: ticker[:symbol])
    end
  end
end
