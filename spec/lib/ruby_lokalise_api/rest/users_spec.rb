# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Users do
  specify '#user' do
    user_id = 1234
    stub(
      uri: "users/#{user_id}",
      resp: { body: fixture('users/user') }
    )

    user = test_client.user user_id

    expect(user).to be_an_instance_of(RubyLokaliseApi::Resources::User)

    expect(user.id).to eq(user_id)
    expect(user.uuid).to eq('01655d20-4648-5d1e-8dd7-6216606b7819')
    expect(user.email).to eq('test@example.com')
    expect(user.fullname).to eq('Test User')
  end
end
