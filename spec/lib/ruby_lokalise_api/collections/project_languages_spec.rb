# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::ProjectLanguages do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:pagination_params) { { page: 1, limit: 2 } }
  let(:pagination_headers) do
    {
      'x-pagination-total-count': '4',
      'x-pagination-page-count': '2',
      'x-pagination-limit': '2',
      'x-pagination-page': '1'
    }
  end

  it 'supports pagination' do
    stub(
      uri: "projects/#{project_id}/languages",
      req: { query: pagination_params },
      resp: {
        body: fixture('languages/project_languages_page1'),
        headers: pagination_headers
      }
    )

    stub(
      uri: "projects/#{project_id}/languages",
      req: { query: pagination_params.merge(page: 2) },
      resp: {
        body: fixture('languages/project_languages_page2'),
        headers: pagination_headers.merge('x-pagination-page': 2)
      }
    )

    langs = test_client.project_languages project_id, pagination_params

    expect(langs.collection.length).to eq(2)
    expect_to_have_valid_resources(langs)
    expect(langs.next_page?).to be true
    expect(langs.prev_page?).to be false

    next_page_langs = langs.next_page

    expect(next_page_langs).to be_an_instance_of(described_class)

    expect(next_page_langs[0].lang_id).to eq(673)
    expect(next_page_langs.next_page?).to be false
    expect(next_page_langs.prev_page?).to be true

    prev_page_langs = next_page_langs.prev_page

    expect(prev_page_langs).to be_an_instance_of(described_class)
  end
end
