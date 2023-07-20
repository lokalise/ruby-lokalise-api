# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::TeamUser do
  let(:team_id) { 176_692 }

  let(:loaded_user_fixture) { loaded_fixture('team_users/team_user') }

  let(:user_id) { loaded_user_fixture['team_user']['user_id'] }

  let(:user_endpoint) do
    endpoint name: 'TeamUsers', client: test_client, params: { query: [team_id, user_id] }
  end

  let(:user) do
    resource 'TeamUser', response(loaded_user_fixture, user_endpoint)
  end

  specify '#reload_data' do
    stub(
      uri: "teams/#{team_id}/users/#{user_id}",
      resp: { body: fixture('team_users/team_user') }
    )

    reloaded_user = user.reload_data

    expect(reloaded_user).to be_an_instance_of(described_class)
    expect(reloaded_user.user_id).to eq(user_id)
  end

  specify '#update' do
    user_data = {
      role: 'admin'
    }

    stub(
      uri: "teams/#{team_id}/users/#{user_id}",
      req: { body: user_data, verb: :put },
      resp: { body: fixture('team_users/update_team_user') }
    )

    updated_user = user.update user_data

    expect(updated_user).to be_an_instance_of(described_class)
    expect(updated_user.user_id).to eq(user_id)
    expect(updated_user.role).to eq(user_data[:role])
  end

  specify '#destroy' do
    stub(
      uri: "teams/#{team_id}/users/#{user_id}",
      req: { verb: :delete },
      resp: { body: fixture('team_users/destroy_team_user') }
    )

    resp = user.destroy

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.team_id).to eq(team_id)
    expect(resp.team_user_deleted).to be true
  end
end
