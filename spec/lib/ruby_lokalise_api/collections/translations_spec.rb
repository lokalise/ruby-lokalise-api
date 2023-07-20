# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::Translations do
  let(:project_id) { '88628569645b945648b474.25982965' }

  let(:pagination_params) { { page: 4, limit: 2 } }
  let(:pagination_headers) do
    {
      'x-pagination-total-count': '35',
      'x-pagination-page-count': '18',
      'x-pagination-limit': '2',
      'x-pagination-page': '4'
    }
  end

  it 'supports pagination' do
    stub(
      uri: "projects/#{project_id}/translations",
      req: { query: pagination_params },
      resp: {
        body: fixture('translations/translations_page4'),
        headers: pagination_headers
      }
    )

    stub(
      uri: "projects/#{project_id}/translations",
      req: { query: pagination_params.merge(page: 3) },
      resp: {
        body: fixture('translations/translations_page3'),
        headers: pagination_headers.merge('x-pagination-page': 3)
      }
    )

    translations = test_client.translations project_id, pagination_params

    expect(translations.collection.length).to eq(2)
    expect_to_have_valid_resources(translations)
    expect(translations.next_page?).to be true
    expect(translations.prev_page?).to be true

    prev_page_translations = translations.prev_page

    expect(prev_page_translations).to be_an_instance_of(described_class)
    expect(prev_page_translations[0].translation_id).to eq(2_574_122_386)
    expect(prev_page_translations.next_page?).to be true
    expect(prev_page_translations.prev_page?).to be true

    next_page_translations = prev_page_translations.next_page

    expect(next_page_translations).to be_an_instance_of(described_class)
  end
end
