# frozen_string_literal: true

module TestClient
  def test_client(token = nil, params = {})
    RubyLokaliseApi.client(token || ENV.fetch('LOKALISE_API_TOKEN', nil), params)
  end

  def auth_client
    RubyLokaliseApi.auth_client(ENV.fetch('OAUTH2_CLIENT_ID', nil), ENV.fetch('OAUTH2_CLIENT_SECRET', nil))
  end

  def test_oauth2_client(token = nil, params = {})
    RubyLokaliseApi.oauth2_client(token || ENV.fetch('OAUTH2_TOKEN', nil), params)
  end
end
