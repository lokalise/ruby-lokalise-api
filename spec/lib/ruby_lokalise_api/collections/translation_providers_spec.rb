# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::TranslationProviders do
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
      uri: "teams/#{team_id}/translation_providers",
      req: { query: pagination_params },
      resp: {
        body: fixture('translation_providers/translation_providers_page2'),
        headers: pagination_headers
      }
    )

    stub(
      uri: "teams/#{team_id}/translation_providers",
      req: { query: pagination_params.merge(page: 1) },
      resp: {
        body: fixture('translation_providers/translation_providers_page1'),
        headers: pagination_headers.merge('x-pagination-page': 1)
      }
    )

    providers = test_client.translation_providers team_id, pagination_params

    expect(providers.collection.length).to eq(2)
    expect_to_have_valid_resources(providers)
    expect(providers.next_page?).to be false
    expect(providers.prev_page?).to be true

    prev_page_providers = providers.prev_page

    expect(prev_page_providers).to be_an_instance_of(described_class)
    expect(prev_page_providers[0].provider_id).to eq(1)
    expect(prev_page_providers.next_page?).to be true
    expect(prev_page_providers.prev_page?).to be false

    next_page_providers = prev_page_providers.next_page

    expect(next_page_providers).to be_an_instance_of(described_class)
  end
end
