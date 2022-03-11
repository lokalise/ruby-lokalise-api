# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Error do
  include RubyLokaliseApi::Request

  before { RubyLokaliseApi.reset_client! }

  after { RubyLokaliseApi.reset_client! }

  it 'raises a generic error when the code is unknown' do
    expect do
      VCR.use_cassette('error_unknown_code') do
        get 'projects', RubyLokaliseApi.client('invalid')
      end
    end.to raise_error(described_class)
  end

  it 'handles an exception when the response does not contain an error key' do
    expect do
      VCR.use_cassette('error_no_error_key') do
        get 'projects', RubyLokaliseApi.client('invalid')
      end
    end.to raise_error(RubyLokaliseApi::Error::BadRequest)
  end

  it 'raises BadRequest when API token is invalid' do
    expect do
      VCR.use_cassette('error_invalid_token') do
        get 'projects', RubyLokaliseApi.client('invalid')
      end
    end.to raise_error(RubyLokaliseApi::Error::BadRequest)
  end

  it 'raises NotFound when the provided path cannot be found' do
    expect do
      VCR.use_cassette('error_not_found') do
        get 'invalid_path', test_client
      end
    end.to raise_error(RubyLokaliseApi::Error::NotFound)
  end
end
