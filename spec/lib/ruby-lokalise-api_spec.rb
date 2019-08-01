RSpec.describe Lokalise do
  specify '.client' do
    expect(test_client).to be_an_instance_of(Lokalise::Client)
    expect(test_client.token).to eq(ENV['LOKALISE_API_TOKEN'])
    expect(test_client.timeout).to be_nil
    expect(test_client.open_timeout).to be_nil
  end

  specify '.reset_client!' do
    expect(test_client).to be_an_instance_of(Lokalise::Client)
    Lokalise.reset_client!
    current_client = Lokalise.instance_variable_get '@client'
    expect(current_client).to be_nil
  end

  context 'client params' do
    before(:each) { Lokalise.reset_client! }
    after(:all) { Lokalise.reset_client! }

    it 'should be possible to customize timeout' do
      custom_client = Lokalise.client(ENV['LOKALISE_API_TOKEN'], timeout: 600)
      expect(custom_client.timeout).to eq(600)
    end

    it 'should be possible to customize open timeout' do
      custom_client = Lokalise.client(ENV['LOKALISE_API_TOKEN'], open_timeout: 100)
      expect(custom_client.open_timeout).to eq(100)
    end
  end
end
