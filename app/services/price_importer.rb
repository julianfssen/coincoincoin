class PriceImporter
  include CoingeckoRuby

  def initialize
    @client = CoingeckoRuby.client
  end

  def import_daily_historical_derivative_prices_from_markets
    markets = DerivativeExchange.all
    markets.each do |market|
      import_daily_historical_derivative_prices_for_market(market_id: market.coingecko_exchange_id)
    end
  end

  def import_daily_historical_derivative_prices_for_market(market_id:)
    response = @client.get_derivative_exchange(id: market_id, options: { include_tickers: true })
    tickers = response['tickers']
    derivative_exchange_id = DerivativeExchange.find_by(coingecko_exchange_id: market_id).id
    tickers.each do |ticker|
      derivative = Derivative.find_or_initialize_by(symbol: ticker['symbol'], derivative_exchange_id: derivative_exchange_id)
      derivative.update(
        base: ticker['base'],
        target: ticker['target'],
        url: ticker['trade_url'],
        price: ticker['last'],
        price_percentage_change_24h: ticker['h24_percentage_change'],
        volume_24h: ticker['converted_volume']['usd'],
        open_interest: ticker['open_interest_usd'],
        bid_ask_spread: ticker['bid_ask_spread'],
        funding_rate: ticker['funding_rate'],
        contract_type: ticker['contract_type'],
        expiring_at: ticker['expired_at'].nil? ? 0 : ticker['expired_at']
      )
      # derivative.update(expired: true) if Time.at(ticker['expired_at']) && Time.at(ticker['expired_at']) < Time.now
    end
  end
end
