# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Client do
  specify '#jwt' do
    resp = VCR.use_cassette('jwt') do
      test_client.jwt
    end

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Resources::Jwt)
    expect(resp.jwt).to include('eyJ0eXAiOi')
  end
end
