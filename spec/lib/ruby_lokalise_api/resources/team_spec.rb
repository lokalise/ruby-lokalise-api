# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Team do
  subject do
    described_class.new response(nil, nil)
  end

  specify '#reload_data' do
    team_id = 273_879

    stub(
      uri: "teams/#{team_id}",
      resp: { body: fixture('teams/team') }
    )

    team = test_client.team team_id

    expect(team.team_id).to eq(team_id)

    reloaded_team = team.reload_data

    expect(reloaded_team.team_id).to eq(team_id)
    expect(reloaded_team.name).to eq('Ruby Team')
  end

  it { is_expected.not_to respond_to(:update) }
  it { is_expected.not_to respond_to(:destroy) }
end
