RSpec.describe Lokalise::Client do
  specify '#teams' do
    teams = VCR.use_cassette('teams') do
      test_client.teams page: 1, limit: 1
    end

    team = teams.collection.first

    expect(teams.collection.length).to eq(1)
    expect(teams.total_results).to eq(1)
    expect(teams.total_pages).to eq(1)
    expect(teams.results_per_page).to eq(1)
    expect(teams.current_page).to eq(1)

    expect(team.team_id).to eq(176_692)
    expect(team.name).to eq('Ilya\'s Team')
    expect(team.created_at).to eq('2018-08-21 17:35:25 (Etc/UTC)')
    expect(team.plan).to eq('Trial')
    expect(team.quota_usage['users']).to eq(4)
    expect(team.quota_allowed['keys']).to eq(999_999_999)
  end
end
