class PriceImporter
  include CoingeckoRuby

  def initialize
    @client = CoingeckoRuby::Client.new
  end

  def import!
    import_daily_historical_derivative_prices_from_markets
  end

  def import_daily_historical_derivative_prices_from_markets
    markets = DerivativeExchange.pluck(:id, :coingecko_exchange_id)
    markets.each do |derivative_exchange_id, market_id|
      import_daily_historical_derivative_prices_for_market(derivative_exchange_id, market_id)
    end
  end

  def import_daily_historical_derivative_prices_for_market(derivative_exchange_id, market_id)
    pp market_id
    response = @client.derivative_exchange(market_id, include_tickers: 'unexpired')
    tickers = response['tickers']
    tickers.each_slice(100) do |batch|
      batch.each do |ticker|
        begin
          puts "Symbol from CG response: #{ticker['symbol']}"
          derivative = Derivative.find_or_initialize_by(symbol: ticker['symbol'], derivative_exchange_id: derivative_exchange_id)
          puts "Importing derivative: #{derivative.symbol}"
          derivative_daily_historical_price = DerivativeDailyHistoricalPrice.new(derivative_id: derivative.id)
          derivative_daily_historical_price.update(derivative_exchange_id: derivative_exchange_id, price: ticker['last'])
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
            expiring_at: ticker['expired_at'].nil? ? 0 : ticker['expired_at'],
            image_url: ticker['image_url']
          )
        rescue StandardError => e
          Rails.logger.error "Failed to download price data for #{ticker['symbol']} with error: #{e}"
          next
        end
      end
    end
  end
end
