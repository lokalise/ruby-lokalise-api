# TODO: rewrite with raw `get` method
RSpec.describe Lokalise::Error do
  include Lokalise::Request

  after(:each) { Lokalise.reset_client! }

  it 'should raise BadRequest when API token is invalid' do
    expect do
      VCR.use_cassette('error_invalid_token') do
        get 'projects', Lokalise.client('invalid')
      end
    end.to raise_error(Lokalise::Error::BadRequest)
  end

  it 'should raise NotFound when the provided path cannot be found' do
    expect do
      VCR.use_cassette('error_not_found') do
        get 'invalid_path', test_client
      end
    end.to raise_error(Lokalise::Error::NotFound)
  end
end
