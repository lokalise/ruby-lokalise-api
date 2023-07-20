# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::Contributors do
  let(:project_id) { '20603843642073fe124fb8.14291681' }
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
      uri: "projects/#{project_id}/contributors",
      req: { query: pagination_params },
      resp: {
        body: fixture('contributors/contributors_paginated'),
        headers: pagination_headers
      }
    )

    stub(
      uri: "projects/#{project_id}/contributors",
      req: { query: pagination_params.merge(page: 2) },
      resp: {
        body: fixture('contributors/contributors_next_page'),
        headers: pagination_headers.merge('x-pagination-page': 2)
      }
    )

    contributors = test_client.contributors project_id, pagination_params

    expect(contributors.collection.length).to eq(2)
    expect_to_have_valid_resources(contributors)
    expect(contributors.next_page?).to be true
    expect(contributors.prev_page?).to be false

    next_page_contributors = contributors.next_page

    expect(next_page_contributors).to be_an_instance_of(described_class)
    expect(next_page_contributors[0].fullname).to eq('Ann')
    expect(next_page_contributors.next_page?).to be false
    expect(next_page_contributors.prev_page?).to be true

    prev_page_contributors = next_page_contributors.prev_page

    expect(prev_page_contributors).to be_an_instance_of(described_class)
  end
end
