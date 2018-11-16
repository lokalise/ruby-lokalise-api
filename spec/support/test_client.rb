module TestClient
  def test_client
    return @client if @client
    @client = Lokalise.client ENV['LOKALISE_API_TOKEN']
  end
end