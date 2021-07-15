# frozen_string_literal: true

RSpec.describe Lokalise do
  specify '.client' do
    expect(test_client).to be_an_instance_of(Lokalise::Client)
    expect(test_client.token).to eq(ENV['LOKALISE_API_TOKEN'])
    expect(test_client.timeout).to be_nil
    expect(test_client.open_timeout).to be_nil
    expect(test_client.enable_compression).to be false
  end

  specify '.reset_client!' do
    expect(test_client).to be_an_instance_of(Lokalise::Client)
    described_class.reset_client!
    current_client = described_class.instance_variable_get '@client'
    expect(current_client).to be_nil
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

    it 'is possible to customize compression' do
      custom_client = described_class.client(ENV['LOKALISE_API_TOKEN'], enable_compression: true)
      expect(custom_client.enable_compression).to be true
    end
  end
end
