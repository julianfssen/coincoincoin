class CoinsImporter
  def initialize
    @client = CoingeckoRuby::Client.new
  end

  def import!
    import_coins
  end

  def import_coins
    coins_to_import = check_for_missing_coins
    coins_data = coingecko_coins_list
    normalized_coins_data = normalize_coins_data(coins_data)
    coins_to_import.each do |coin|
      normalized_coin_data = normalized_coins_data[coin]
      next if normalized_coin_data.blank?

      puts "Importing #{coin} data from CoinGecko"
      ticker = normalized_coin_data['symbol']
      name = normalized_coin_data['name']
      coin = Coin.new(name: name, ticker: ticker)
      coin.save
    rescue StandardError => e
      puts "Failed to save #{coin}. Error: #{e}"
      next
    end
  end

  def check_for_missing_coins
    base_coins = Derivative.pluck(:base).uniq
    target_coins = Derivative.pluck(:target).uniq
    current_coins = base_coins.concat(target_coins).uniq
    current_coins = current_coins.collect(&:downcase)
    coins_in_db = Coin.pluck(:ticker)
    current_coins - coins_in_db
  end

  def coingecko_coins_list
    @client.coins_list
  end

  def normalize_coins_data(coins_data)
    normalized_coins_data = {}
    coins_data.each do |data|
      key = data['symbol']
      normalized_coins_data[key] = data
    end
    normalized_coins_data
  end
end
