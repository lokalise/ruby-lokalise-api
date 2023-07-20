# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::TeamUserGroups do
  let(:team_id) { 176_692 }

  let(:pagination_params) { { page: 2, limit: 2 } }
  let(:pagination_headers) do
    {
      'x-pagination-total-count': '4',
      'x-pagination-page-count': '2',
      'x-pagination-limit': '2',
      'x-pagination-page': '2'
    }
  end

  it 'supports pagination' do
    stub(
      uri: "teams/#{team_id}/groups",
      req: { query: pagination_params },
      resp: {
        body: fixture('team_user_groups/team_user_groups_page2'),
        headers: pagination_headers
      }
    )

    stub(
      uri: "teams/#{team_id}/groups",
      req: { query: pagination_params.merge(page: 1) },
      resp: {
        body: fixture('team_user_groups/team_user_groups_page1'),
        headers: pagination_headers.merge('x-pagination-page': 1)
      }
    )

    groups = test_client.team_user_groups team_id, pagination_params

    expect(groups.collection.length).to eq(2)
    expect_to_have_valid_resources(groups)
    expect(groups.next_page?).to be false
    expect(groups.prev_page?).to be true

    prev_page_groups = groups.prev_page

    expect(prev_page_groups).to be_an_instance_of(described_class)
    expect(prev_page_groups[0].group_id).to eq(2639)
    expect(prev_page_groups.next_page?).to be true
    expect(prev_page_groups.prev_page?).to be false

    next_page_groups = prev_page_groups.next_page

    expect(next_page_groups).to be_an_instance_of(described_class)
  end
end
