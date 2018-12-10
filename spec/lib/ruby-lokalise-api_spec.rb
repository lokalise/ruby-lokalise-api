RSpec.describe Lokalise do
  specify '.client' do
    expect(test_client).to be_an_instance_of(Lokalise::Client)
    expect(test_client.token).to eq(ENV['LOKALISE_API_TOKEN'])
  end

  specify '.reset_client!' do
    expect(test_client).to be_an_instance_of(Lokalise::Client)
    Lokalise.reset_client!
    current_client = Lokalise.instance_variable_get '@client'
    expect(current_client).to be_nil
  end
end
