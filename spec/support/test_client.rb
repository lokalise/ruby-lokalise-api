module TestClient
  def test_client(token = nil)
    Lokalise.client token || ENV['LOKALISE_API_TOKEN']
  end
end
