CLIENT_ID = Rails.application.credentials.twitter[:client_id]
CLIENT_SECRET = Rails.application.credentials.twitter[:client_secret]

module TwitterClient
  def self.included(base)
    pp 'included'
    @client = Octokit::Client.new(client_id: CLIENT_ID, client_secret: CLIENT_SECRET)
  end

  def self.get_user(username)
    @client.user username
  end
end
