require 'net/http'
require 'openssl'

class NewsService
  def self.search(query)
    query = ERB::Util.url_encode(query)
    url = URI("https://cryptonews-api.com/api/v1?tickers=#{query}&items=5&token=cspc6ajzxti8rwfocjdhljqihk2xgpgekcym5kz4")
    response = Net::HTTP.get(url)
    JSON.parse(response)
  end
end
