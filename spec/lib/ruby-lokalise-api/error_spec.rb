# frozen_string_literal: true

RSpec.describe Lokalise::Error do
  include Lokalise::Request

  before { Lokalise.reset_client! }

  after { Lokalise.reset_client! }

  it 'raises BadRequest when API token is invalid' do
    expect do
      VCR.use_cassette('error_invalid_token') do
        get 'projects', Lokalise.client('invalid')
      end
    end.to raise_error(Lokalise::Error::BadRequest)
  end

  it 'raises NotFound when the provided path cannot be found' do
    expect do
      VCR.use_cassette('error_not_found') do
        get 'invalid_path', test_client
      end
    end.to raise_error(Lokalise::Error::NotFound)
  end
end
