RSpec.describe Lokalise::Error do
  it 'should raise BadRequest when API token is invalid' do
    expect do
      VCR.use_cassette('error_invalid_token') do
        Lokalise::Collections::Base.send :load_collection, 'projects', 'invalid', {}
      end
    end.to raise_error(Lokalise::Error::BadRequest)
  end

  it 'should raise BadRequest when the provided id is invalid' do
    expect do
      VCR.use_cassette('error_project_bad_request') do
        test_client.project '123.45'
      end
    end.to raise_error(Lokalise::Error::BadRequest)
  end

  it 'should raise NotFound when the provided path cannot be found' do
    expect do
      VCR.use_cassette('error_not_found') do
        Lokalise::Collections::Base.send :load_collection, 'invalid_path', test_client.token, {}
      end
    end.to raise_error(Lokalise::Error::NotFound)
  end
end
