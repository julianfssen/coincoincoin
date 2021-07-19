class ExchangeImporter
  include CoingeckoRuby

  def initialize
    @client = CoingeckoRuby::Client.new
  end

  def import_derivative_exchanges(**options)
    exchange_rate = @client.exchange_rate(from: 'bitcoin')['bitcoin']['usd']
    response = @client.derivative_exchanges(**options)
    response.each do |r|
      exchange = DerivativeExchange.find_or_initialize_by(coingecko_exchange_id: r['id'])
      exchange.update(
        name: r['name'],
        image_url: r['image'],
        url: r['url'],
        trade_volume_24h: r['trade_volume_24h_btc'].nil? ? 0 : r['trade_volume_24h_btc'] * exchange_rate,
        open_interest: r['open_interest_btc'].nil? ? 0 : r['open_interest_btc'] * exchange_rate
      )
    end
  end
end
