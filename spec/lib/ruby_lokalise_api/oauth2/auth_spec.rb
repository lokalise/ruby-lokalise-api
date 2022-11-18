# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::OAuth2::Auth do
  describe '#auth' do
    it 'returns auth code' do
      uri = auth_client.auth scope: 'read_projects'
      expect(uri).to include(auth_client.base_url.to_s)
      expect(uri).to include('auth?client_id=')
      expect(uri).to include('&scope=read_projects')
    end

    it 'allows to pass an array of scopes' do
      scopes = %w[write_projects write_team_groups write_tasks]
      uri = auth_client.auth scope: scopes
      expect(uri).to include(auth_client.base_url.to_s)
      expect(uri).to include('auth?client_id=')
      expect(uri).to include("&scope=#{scopes.join('+')}")
    end

    it 'allows to set redirect_uri' do
      uri = auth_client.auth scope: 'read_projects', redirect_uri: 'http://example.com/callback'
      expect(uri).to include(auth_client.base_url.to_s)
      expect(uri).to include('example.com%2Fcallback')
    end

    it 'allows to set state' do
      state = '123abc'
      uri = auth_client.auth scope: 'read_projects', state: state
      expect(uri).to include(auth_client.base_url.to_s)
      expect(uri).to include(state)
    end
  end

  describe '#token' do
    it 'returns an OAuth2 token' do
      resp = VCR.use_cassette('oauth2/token') do
        auth_client.token ENV.fetch('OAUTH2_CODE', nil)
      end

      expect(resp).to be_an_instance_of(RubyLokaliseApi::OAuth2::Token)
      expect(resp.access_token).not_to be_nil
      expect(resp.refresh_token).not_to be_nil
      expect(resp.expires_in).to eq(3600)
      expect(resp.token_type).to eq('Bearer')
    end

    it 'raises an error when the code is invalid' do
      expect do
        VCR.use_cassette('oauth2/token_error') do
          auth_client.token 'incorrect_code'
        end
      end.to raise_error(RubyLokaliseApi::Error::BadRequest)
    end
  end

  describe '#refresh' do
    it 'returns a refreshed OAuth2 token' do
      resp = VCR.use_cassette('oauth2/refresh') do
        auth_client.refresh ENV.fetch('OAUTH2_REFRESH_TOKEN', nil)
      end

      expect(resp).to be_an_instance_of(RubyLokaliseApi::OAuth2::Refresh)
      expect(resp.access_token).not_to be_nil
      expect(resp.scope).to eq('write_projects write_team_groups write_tasks')
      expect(resp.expires_in).to eq(3600)
      expect(resp.token_type).to eq('Bearer')
    end

    it 'raises an error when the token is invalid' do
      expect do
        VCR.use_cassette('oauth2/refresh_error') do
          auth_client.refresh 'incorrect_token'
        end
      end.to raise_error(RubyLokaliseApi::Error::BadRequest)
    end
  end
end
