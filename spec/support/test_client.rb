# frozen_string_literal: true

module TestClient
  def test_client(token = nil, params = {})
    RubyLokaliseApi.client(token || ENV['LOKALISE_API_TOKEN'], params)
  end

  def test_oauth2_client(token = nil, params = {})
    RubyLokaliseApi.oauth2_client(token || ENV['OAUTH2_TOKEN'], params)
  end

  def auth_client
    RubyLokaliseApi.auth_client(ENV['OAUTH2_CLIENT_ID'], ENV['OAUTH2_CLIENT_SECRET'])
  end
end
