# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::KeyComments do
  let(:project_id) { '20603843642073fe124fb8.14291681' }
  let(:key_id) { 301_832_195 }
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
      uri: "projects/#{project_id}/keys/#{key_id}/comments",
      req: { query: pagination_params },
      resp: {
        body: fixture('comments/comments_paginated'),
        headers: pagination_headers
      }
    )

    stub(
      uri: "projects/#{project_id}/keys/#{key_id}/comments",
      req: { query: pagination_params.merge(page: 2) },
      resp: {
        body: fixture('comments/comments_next_page'),
        headers: pagination_headers.merge('x-pagination-page': 2)
      }
    )

    comments = test_client.comments project_id, key_id, pagination_params

    expect(comments.collection.length).to eq(2)
    expect_to_have_valid_resources(comments)
    expect(comments.next_page?).to be true
    expect(comments.prev_page?).to be false

    next_page_comments = comments.next_page

    expect(next_page_comments).to be_an_instance_of(described_class)
    expect(next_page_comments[0].comment).to eq('<p>How are things?</p>')
    expect(next_page_comments.next_page?).to be false
    expect(next_page_comments.prev_page?).to be true

    prev_page_comments = next_page_comments.prev_page

    expect(prev_page_comments).to be_an_instance_of(described_class)
  end
end
