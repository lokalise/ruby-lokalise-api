# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Client do
  let(:project_id) { '2273827860c1e2473eb195.11207948' }

  specify '#jwt' do
    resp = VCR.use_cassette('jwt') do
      test_client.jwt project_id
    end

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Resources::Jwt)
    expect(resp.jwt).to include('eyJ0eXAiOiJKV1QiLCJ')
  end
end
