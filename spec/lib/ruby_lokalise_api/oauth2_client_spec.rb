# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::OAuth2Client do
  let(:project_id) { '20603843642073fe124fb8.14291681' }
  let(:user_id) { 20_181 }

  it 'allows to perform requests with OAuth 2 token' do
    stub(
      uri: "projects/#{project_id}/contributors/#{user_id}",
      req: { token_header: 'Authorization', token: test_oauth2_client.token },
      resp: { body: fixture('contributors/contributor') }
    )

    contributor = test_oauth2_client.contributor(project_id, user_id)

    expect(contributor).to be_an_instance_of(RubyLokaliseApi::Resources::Contributor)
    expect(contributor.user_id).to eq(user_id)

    reloaded_contributor = contributor.reload_data

    expect(reloaded_contributor).to be_an_instance_of(RubyLokaliseApi::Resources::Contributor)
    expect(reloaded_contributor.user_id).to eq(user_id)
  end
end
