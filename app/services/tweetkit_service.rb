class TweetkitService
  include Tweetkit

  BEARER_TOKEN = Rails.application.credentials.twitter[:bearer_token]

  def initialize
    @client = Tweetkit::Client.new(bearer_token: BEARER_TOKEN)
  end

  def search_tweets(query, **options)
    @client.search(query, **options)
  end
end
