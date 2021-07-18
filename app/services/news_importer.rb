class NewsImporter
  attr_accessor :client

  def initialize
    @client = NewscatcherService.new
  end

  def import!
    import_news_for_derivatives
  end

  def import_news_for_derivatives
    coins = Coin.pluck(:name, :ticker)
    coins.each do |name, ticker|
      next if name.match?(/\[|\]/) # newscatcherapi breaks for queries with brackets

      query = name.downcase
      puts "Searching news for: #{query}"
      news_for_currency = client.search(query)['articles']
      next if news_for_currency.blank?

      news_for_currency.each_with_index do |news, index|
        break if index == 5

        next if news['clean_url'].include? 'reddit'

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
