# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::OAuth2::Auth do
  let(:base_url) { RubyLokaliseApi::Endpoints::OAuth2::OAuth2Endpoint::BASE_URL }

  describe '#auth' do
    it 'returns auth url' do
      uri = auth_client.auth scope: 'read_projects'

      expect(uri).to include(base_url)
      expect(uri).to include('oauth2/auth?client_id=')
      expect(uri).to include('&scope=read_projects')
    end

    it 'allows to pass an array of scopes' do
      scopes = %w[write_projects write_team_groups write_tasks]
      uri = auth_client.auth scope: scopes

      expect(uri).to include(base_url)
      expect(uri).to include('oauth2/auth?client_id=')
      expect(uri).to include("&scope=#{scopes.join('%20')}")
    end

    it 'allows to set redirect_uri' do
      uri = auth_client.auth scope: %w[write_projects read_contributors], redirect_uri: 'http://example.com/callback'

      expect(uri).to include(base_url)
      expect(uri).to include('example.com%2Fcallback')
    end

    it 'allows to set state' do
      state = '123abc'
      uri = auth_client.auth scope: 'read_projects', state: state

      expect(uri).to include(base_url)
      expect(uri).to include(state)
    end
  end

  specify '#token' do
    code = ENV.fetch('OAUTH2_CODE', nil)

    params = {
      client_id: auth_client.client_id,
      client_secret: auth_client.client_secret,
      grant_type: 'authorization_code',
      code: code
    }

    resp_body = {
      access_token: ENV.fetch('OAUTH2_TOKEN', nil),
      refresh_token: ENV.fetch('OAUTH2_REFRESH_TOKEN', nil),
      expires_in: 3600,
      token_type: 'Bearer'
    }

    stub(
      uri: 'token',
      req: { body: params, verb: :post, skip_token: true, base_url: base_url },
      resp: { body: resp_body }
    )

    token = auth_client.token(code)

    expect(token).to be_an_instance_of(RubyLokaliseApi::Resources::OAuth2Token)
    expect(token.access_token).to eq(ENV.fetch('OAUTH2_TOKEN', nil))
    expect(token.refresh_token).to eq(ENV.fetch('OAUTH2_REFRESH_TOKEN', nil))
    expect(token.expires_in).to eq(3600)
    expect(token.token_type).to eq('Bearer')
  end

  specify '#refresh' do
    refresh_token = ENV.fetch('OAUTH2_REFRESH_TOKEN', nil)

    params = {
      client_id: auth_client.client_id,
      client_secret: auth_client.client_secret,
      grant_type: 'refresh_token',
      refresh_token: refresh_token
    }

    resp_body = {
      access_token: ENV.fetch('OAUTH2_TOKEN_REFRESHED', nil),
      scope: 'write_projects read_contributors',
      expires_in: 3600,
      token_type: 'Bearer'
    }

    stub(
      uri: 'token',
      req: { body: params, verb: :post, skip_token: true, base_url: base_url },
      resp: { body: resp_body }
    )

    token = auth_client.refresh(refresh_token)

    expect(token).to be_an_instance_of(RubyLokaliseApi::Resources::OAuth2RefreshedToken)

    expect(token.access_token).to eq(ENV.fetch('OAUTH2_TOKEN_REFRESHED', nil))
    expect(token.expires_in).to eq(3600)
    expect(token.token_type).to eq('Bearer')
    expect(token.scope).to eq('write_projects read_contributors')
  end
end
