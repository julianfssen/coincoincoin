class TweetkitService
  include Tweetkit

  def initialize
    @client = Tweetkit::Client.new(bearer_token: 'AAAAAAAAAAAAAAAAAAAAAF92QwEAAAAAGqboFuBbSHHP%2BQQfpyzKYC0RXV4%3DuJj9zT85r65iwZZOyZIlUFJSxd1CwkGf5SqrhXSpWhuxtZKyi7')
  end

  def search_tweets(query, **options)
    @client.search(query, **options)
  end
end
