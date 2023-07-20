# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::TeamUsers do
  let(:team_id) { 176_692 }
  let(:user_id) { 147_798 }

  specify '#team_users' do
    stub(
      uri: "teams/#{team_id}/users",
      resp: { body: fixture('team_users/team_users') }
    )

    team_users = test_client.team_users team_id

    expect(team_users).to be_an_instance_of(RubyLokaliseApi::Collections::TeamUsers)
    expect_to_have_valid_resources(team_users)

    user = team_users[0]

    expect(user.user_id).to eq(user_id)
  end

  specify '#team_user' do
    stub(
      uri: "teams/#{team_id}/users/#{user_id}",
      resp: { body: fixture('team_users/team_user') }
    )

    user = test_client.team_user team_id, user_id

    expect(user.team_id).to eq(team_id)
    expect(user.user_id).to eq(user_id)
    expect(user.email).to eq('ilya+demo2@lokalise.com')
    expect(user.fullname).to eq('Ilya Demo')
    expect(user.created_at).to eq('2022-01-19 16:16:03 (Etc/UTC)')
    expect(user.created_at_timestamp).to eq(1_642_608_963)
    expect(user.role).to eq('member')
  end

  specify '#update_team_user' do
    user_data = {
      role: 'admin'
    }

    stub(
      uri: "teams/#{team_id}/users/#{user_id}",
      req: { body: user_data, verb: :put },
      resp: { body: fixture('team_users/update_team_user') }
    )

    user = test_client.update_team_user team_id, user_id, user_data

    expect(user).to be_an_instance_of(RubyLokaliseApi::Resources::TeamUser)
    expect(user.user_id).to eq(user_id)
    expect(user.role).to eq(user_data[:role])
  end

  specify '#destroy_team_user' do
    stub(
      uri: "teams/#{team_id}/users/#{user_id}",
      req: { verb: :delete },
      resp: { body: fixture('team_users/destroy_team_user') }
    )

    resp = test_client.destroy_team_user team_id, user_id

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.team_id).to eq(team_id)
    expect(resp.team_user_deleted).to be true
  end
end
