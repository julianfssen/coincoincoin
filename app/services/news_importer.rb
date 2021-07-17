class NewsImporter
  attr_accessor :client

  def initialize
    @client = NewscatcherService.new
  end

  def import_news_for_derivatives
    base_currencies = Derivative.pluck(:base).uniq
    target_currencies = Derivative.pluck(:target).uniq
    currencies = base_currencies.concat(target_currencies).uniq
    currencies.each do |currency|
      pp "Searching news for #{currency}"
      news_for_currency = client.search(currency)['articles']
      next if news_for_currency.blank?

      news_for_currency.each do |news|
        record = News.new(unique_id: news['_id'])
        next unless record.save

        record.update(
          currency: currency,
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
