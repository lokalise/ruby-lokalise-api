# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::Webhooks do
  let(:project_id) { '88628569645b945648b474.25982965' }

  let(:pagination_params) { { page: 2, limit: 2 } }
  let(:pagination_headers) do
    {
      'x-pagination-total-count': '3',
      'x-pagination-page-count': '2',
      'x-pagination-limit': '2',
      'x-pagination-page': '2'
    }
  end

  it 'supports pagination' do
    stub(
      uri: "projects/#{project_id}/webhooks",
      req: { query: pagination_params },
      resp: {
        body: fixture('webhooks/webhooks_page2'),
        headers: pagination_headers
      }
    )

    stub(
      uri: "projects/#{project_id}/webhooks",
      req: { query: pagination_params.merge(page: 1) },
      resp: {
        body: fixture('webhooks/webhooks_page1'),
        headers: pagination_headers.merge('x-pagination-page': 1)
      }
    )

    webhooks = test_client.webhooks project_id, pagination_params

    expect(webhooks.collection.length).to eq(1)
    expect_to_have_valid_resources(webhooks)
    expect(webhooks.next_page?).to be false
    expect(webhooks.prev_page?).to be true

    prev_page_webhooks = webhooks.prev_page

    expect(prev_page_webhooks).to be_an_instance_of(described_class)
    expect(prev_page_webhooks[0].webhook_id).to eq('b47d698677ba426854ceee2982fe304d84c547f4')
    expect(prev_page_webhooks.next_page?).to be true
    expect(prev_page_webhooks.prev_page?).to be false

    next_page_webhooks = prev_page_webhooks.next_page

    expect(next_page_webhooks).to be_an_instance_of(described_class)
  end
end
