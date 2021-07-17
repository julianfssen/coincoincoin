require 'uri'
require 'net/http'
require 'openssl'

class NewscatcherService
  attr_accessor :client
  attr_writer :last_request_time

  def initialize
    @client = Net::HTTP.new('free-news.p.rapidapi.com', 443)
    @client.use_ssl = true
    @client.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  def last_request_time
    @last_request_time || 0
  end

  def search(query)
    url = URI("https://free-news.p.rapidapi.com/v1/search?q=#{query}&lang=en")
    request = Net::HTTP::Get.new(url)
    request['x-rapidapi-key'] = Rails.application.credentials.rapidapi[:newscatcher_key]
    request['x-rapidapi-host'] = 'free-news.p.rapidapi.com'
    current_request_time = Time.now.to_i
    difference = current_request_time - last_request_time
    if difference < 1
      puts "Rate limit reached for Newscatcher service for query: #{query}. Sleeping for 1 seconds until next request"
      sleep 1
    end
    self.last_request_time = Time.now.to_i
    response = client.request(request)
    JSON.parse(response.body)
  end
end
