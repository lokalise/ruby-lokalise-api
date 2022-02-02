# frozen_string_literal: true

RSpec.describe Lokalise do
  specify '.client' do
    expect(test_client).to be_an_instance_of(Lokalise::Client)
    expect(test_client.token).to eq(ENV['LOKALISE_API_TOKEN'])
    expect(test_client.timeout).to be_nil
    expect(test_client.open_timeout).to be_nil
  end

  specify '.reset_client!' do
    expect(test_client).to be_an_instance_of(Lokalise::Client)
    described_class.reset_client!
    current_client = described_class.instance_variable_get :@client
    expect(current_client).to be_nil
  end

  specify '.oauth_client' do
    expect(test_oauth_client).to be_an_instance_of(Lokalise::OAuthClient)
    expect(test_oauth_client.token).to eq("Bearer #{ENV['LOKALISE_API_TOKEN']}")
    expect(test_oauth_client.timeout).to be_nil
    expect(test_oauth_client.open_timeout).to be_nil
  end

  specify '.reset_oauth_client!' do
    expect(test_oauth_client).to be_an_instance_of(Lokalise::OAuthClient)
    described_class.reset_oauth_client!
    current_oauth_client = described_class.instance_variable_get :@oauth_client
    expect(current_oauth_client).to be_nil
  end

  context 'with client params' do
    before { described_class.reset_client! }

    after { described_class.reset_client! }

    it 'is possible to customize timeout' do
      custom_client = described_class.client(ENV['LOKALISE_API_TOKEN'], timeout: 600)
      expect(custom_client.timeout).to eq(600)
    end

    it 'is possible to customize open timeout' do
      custom_client = described_class.client(ENV['LOKALISE_API_TOKEN'], open_timeout: 100)
      expect(custom_client.open_timeout).to eq(100)
    end
  end
end
