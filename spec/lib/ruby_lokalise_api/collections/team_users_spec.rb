# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::TeamUsers do
  let(:team_id) { 176_692 }

  let(:pagination_params) { { page: 2, limit: 3 } }
  let(:pagination_headers) do
    {
      'x-pagination-total-count': '24',
      'x-pagination-page-count': '8',
      'x-pagination-limit': '3',
      'x-pagination-page': '2'
    }
  end

  it 'supports pagination' do
    stub(
      uri: "teams/#{team_id}/users",
      req: { query: pagination_params },
      resp: {
        body: fixture('team_users/team_users_page2'),
        headers: pagination_headers
      }
    )

    stub(
      uri: "teams/#{team_id}/users",
      req: { query: pagination_params.merge(page: 1) },
      resp: {
        body: fixture('team_users/team_users_page1'),
        headers: pagination_headers.merge('x-pagination-page': 1)
      }
    )

    users = test_client.team_users team_id, pagination_params

    expect(users.collection.length).to eq(3)
    expect_to_have_valid_resources(users)
    expect(users.next_page?).to be true
    expect(users.prev_page?).to be true

    prev_page_users = users.prev_page

    expect(prev_page_users).to be_an_instance_of(described_class)
    expect(prev_page_users[0].user_id).to eq(147_798)
    expect(prev_page_users.next_page?).to be true
    expect(prev_page_users.prev_page?).to be false

    next_page_users = prev_page_users.next_page

    expect(next_page_users).to be_an_instance_of(described_class)
  end
end
