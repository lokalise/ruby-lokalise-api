# frozen_string_literal: true

RSpec.describe RubyLokaliseApi do
  specify '.client' do
    expect(test_client).to be_an_instance_of(RubyLokaliseApi::Client)
    expect(test_client.token).to eq(ENV.fetch('LOKALISE_API_TOKEN', nil))
    expect(test_client.timeout).to be_nil
    expect(test_client.open_timeout).to be_nil
  end

  specify '.reset_client!' do
    expect(test_client).to be_an_instance_of(RubyLokaliseApi::Client)
    described_class.reset_client!
    current_client = described_class.instance_variable_get :@client
    expect(current_client).to be_nil
  end

  specify '.oauth2_client' do
    expect(test_oauth2_client).to be_an_instance_of(RubyLokaliseApi::OAuth2Client)
    expect(test_oauth2_client.token).to eq("Bearer #{ENV.fetch('OAUTH2_TOKEN', nil)}")
    expect(test_oauth2_client.timeout).to be_nil
    expect(test_oauth2_client.open_timeout).to be_nil
  end

  specify '.reset_oauth2_client!' do
    expect(test_oauth2_client).to be_an_instance_of(RubyLokaliseApi::OAuth2Client)
    described_class.reset_oauth2_client!
    current_oauth_client = described_class.instance_variable_get :@oauth2_client
    expect(current_oauth_client).to be_nil
  end

  specify '.auth_client' do
    client = described_class.auth_client('id', 'secret', timeout: 5, open_timeout: 10)
    expect(client.client_id).to eq('id')
    expect(client.client_secret).to eq('secret')
    expect(client.timeout).to eq(5)
    expect(client.open_timeout).to eq(10)
  end

  context 'with client params' do
    before { described_class.reset_client! }

    after { described_class.reset_client! }

    it 'is possible to customize timeout' do
      custom_client = described_class.client(ENV.fetch('LOKALISE_API_TOKEN', nil), timeout: 600)
      expect(custom_client.timeout).to eq(600)
    end

    it 'is possible to customize open timeout' do
      custom_client = described_class.client(ENV.fetch('LOKALISE_API_TOKEN', nil), open_timeout: 100)
      expect(custom_client.open_timeout).to eq(100)
    end
  end
end
