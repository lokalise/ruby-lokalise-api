# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::Keys do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:params) { { page: 2, limit: 3, include_comments: 0, include_translations: 0 } }
  let(:pagination_headers) do
    {
      'x-pagination-total-count': '5',
      'x-pagination-page-count': '2',
      'x-pagination-limit': '3',
      'x-pagination-page': '2'
    }
  end

  it 'supports pagination' do
    stub(
      uri: "projects/#{project_id}/keys",
      req: { query: params },
      resp: {
        body: fixture('keys/keys_page2'),
        headers: pagination_headers
      }
    )

    stub(
      uri: "projects/#{project_id}/keys",
      req: { query: params.merge(page: 1) },
      resp: {
        body: fixture('keys/keys_page1'),
        headers: pagination_headers.merge('x-pagination-page': 1)
      }
    )

    keys = test_client.keys project_id, params

    expect(keys.collection.length).to eq(2)
    expect(keys[0].key_id).to eq(319_782_375)
    expect_to_have_valid_resources(keys)
    expect(keys.next_page?).to be false
    expect(keys.prev_page?).to be true

    prev_page_keys = keys.prev_page

    expect(prev_page_keys).to be_an_instance_of(described_class)
    expect(prev_page_keys[0].key_id).to eq(319_782_369)
    expect(prev_page_keys.next_page?).to be true
    expect(prev_page_keys.prev_page?).to be false
  end
end
