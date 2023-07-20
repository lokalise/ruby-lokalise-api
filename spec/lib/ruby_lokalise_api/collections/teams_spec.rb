# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::Teams do
  let(:pagination_params) { { page: 2, limit: 3 } }
  let(:pagination_headers) do
    {
      'x-pagination-total-count': '6',
      'x-pagination-page-count': '2',
      'x-pagination-limit': '3',
      'x-pagination-page': '2'
    }
  end

  it 'supports pagination' do
    stub(
      uri: 'teams',
      req: { query: pagination_params },
      resp: {
        body: fixture('teams/teams_page2'),
        headers: pagination_headers
      }
    )

    stub(
      uri: 'teams',
      req: { query: pagination_params.merge(page: 1) },
      resp: {
        body: fixture('teams/teams_page1'),
        headers: pagination_headers.merge('x-pagination-page': 1)
      }
    )

    teams = test_client.teams pagination_params

    expect(teams.collection.length).to eq(3)
    expect_to_have_valid_resources(teams)
    expect(teams.next_page?).to be false
    expect(teams.prev_page?).to be true

    prev_page_teams = teams.prev_page

    expect(prev_page_teams).to be_an_instance_of(described_class)
    expect(prev_page_teams[0].team_id).to eq(273_879)
    expect(prev_page_teams.next_page?).to be true
    expect(prev_page_teams.prev_page?).to be false

    next_page_teams = prev_page_teams.next_page

    expect(next_page_teams).to be_an_instance_of(described_class)
  end
end
