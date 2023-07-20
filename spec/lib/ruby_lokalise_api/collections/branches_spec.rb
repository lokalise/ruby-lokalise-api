# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::Branches do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:pagination_params) { { page: 1, limit: 2 } }
  let(:pagination_headers) do
    {
      'x-pagination-total-count': '3',
      'x-pagination-page-count': '2',
      'x-pagination-limit': '2',
      'x-pagination-page': '1'
    }
  end

  it 'supports pagination' do
    stub(
      uri: "projects/#{project_id}/branches",
      req: { query: pagination_params },
      resp: {
        body: fixture('branches/branches_paginated'),
        headers: pagination_headers
      }
    )

    stub(
      uri: "projects/#{project_id}/branches",
      req: { query: pagination_params.merge(page: 2) },
      resp: {
        body: fixture('branches/branches_next_page'),
        headers: pagination_headers.merge('x-pagination-page': 2)
      }
    )

    branches = test_client.branches project_id, pagination_params

    expect(branches.collection.length).to eq(2)
    expect_to_have_valid_resources(branches)
    expect(branches.next_page?).to be true
    expect(branches.prev_page?).to be false

    next_page_branches = branches.next_page

    expect(next_page_branches).to be_an_instance_of(described_class)
    expect(next_page_branches[0].branch_id).to eq(309_348)
    expect(next_page_branches.next_page?).to be false
    expect(next_page_branches.prev_page?).to be true

    prev_page_branches = next_page_branches.prev_page

    expect(prev_page_branches).to be_an_instance_of(described_class)
  end
end
