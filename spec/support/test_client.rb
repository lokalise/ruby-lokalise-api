# frozen_string_literal: true

module TestClient
  def test_client(token = nil, params = {})
    Lokalise.client(token || ENV['LOKALISE_API_TOKEN'], params)
  end
end
