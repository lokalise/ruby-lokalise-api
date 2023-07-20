# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Jwts do
  let(:project_id) { '88628569645b945648b474.25982965' }

  specify '#create_jwt' do
    stub(
      uri: "projects/#{project_id}/tokens",
      req: { verb: :post },
      resp: { body: fixture('jwts/create_jwt') }
    )

    token = test_client.create_jwt project_id, service: :ota

    expect(token).to be_an_instance_of(RubyLokaliseApi::Resources::Jwt)
    expect(token.jwt).to eq('123abc')
  end
end
