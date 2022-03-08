# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Client do
  specify '#teams' do
    teams = VCR.use_cassette('teams') do
      test_client.teams page: 2, limit: 1
    end

    team = teams.collection.first

    expect(teams.collection.length).to eq(1)
    expect(teams.total_results).to eq(2)
    expect(teams.total_pages).to eq(2)
    expect(teams.results_per_page).to eq(1)
    expect(teams.current_page).to eq(2)

    expect(team.team_id).to eq(176_692)
    expect(team.name).to eq('Ilya\'s Team')
    expect(team.created_at).to eq('2018-08-21 15:35:25 (Etc/UTC)')
    expect(team.created_at_timestamp).to eq(1_534_865_725)
    expect(team.plan).to eq('Trial')
    expect(team.quota_usage['users']).to eq(9)
    expect(team.quota_allowed['keys']).to eq(999_999_999)
  end
end
