class NewsImporter
  COINS_TO_SEARCH = ["BTC", "LEND", "TRX", "ETH", "SUSHI", "DOGE", "AXS", "XRP", "UNI", "BNB", "XBT", "CHR", "DOT", "ADA"]

  class << self
    def import!
      import_news_for_derivatives
    end

    def import_news_for_derivatives
      coins = Coin.pluck(:name, :ticker)
      COINS_TO_SEARCH.each do |coin|
        query = coin.downcase
        puts "Searching news for: #{query}"
        news_for_currency = NewsService.search(query)['data']
        next if news_for_currency.blank?

        news_for_currency.each do |news|
          record = News.new(unique_id: news['_id'])
          next unless record.save

          record.update(
            currency: ticker.upcase,
            title: news['title'],
            domain: news['clean_url'],
            link: news['link'],
            summary: news['summary'],
            preview_url: news['media'],
            published_date: news['published_date']
          )
        rescue StandardError => e
          puts "Error saving record: #{e}"
          next
        end
      end
    end
  end
end
