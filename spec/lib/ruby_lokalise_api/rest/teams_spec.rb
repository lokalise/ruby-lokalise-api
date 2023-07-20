# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Teams do
  specify '#teams' do
    stub(
      uri: 'teams',
      resp: { body: fixture('teams/teams') }
    )

    teams = test_client.teams

    expect(teams).to be_an_instance_of(RubyLokaliseApi::Collections::Teams)
    expect_to_have_valid_resources(teams)

    team = teams[0]

    expect(team.team_id).to eq(273_879)
    expect(team.name).to eq('Ruby Team')
    expect(team.created_at).to eq('2021-12-15 17:37:23 (Etc/UTC)')
    expect(team.created_at_timestamp).to eq(1_639_589_843)
    expect(team.plan).to eq('Trial')
    expect(team.quota_usage['users']).to eq(1)
    expect(team.quota_allowed['users']).to eq(999_999_999)
  end
end
