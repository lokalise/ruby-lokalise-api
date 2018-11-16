module TestClient
  def test_client
    return @client if @client
    @client = Lokalise.client '123'
  end
end