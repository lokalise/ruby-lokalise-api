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
  let(:cursor_params) do
    {
      cursor: 'eyIxIjoyNjU4ODM0NDUyfQ==',
      pagination: 'cursor',
      limit: 2
    }
  end
  let(:cursor_headers) do
    {
      'x-pagination-limit': cursor_params[:limit],
      'x-pagination-next-cursor': 'eyIxIjoyNjU4ODM0NDUzfQ=='
    }
  end

  it 'supports cursor pagination' do
    stub(
      uri: "projects/#{project_id}/translations",
      req: { query: cursor_params },
      resp: {
        body: fixture('translations/translations_cursor_1'),
        headers: cursor_headers
      }
    )

    stub(
      uri: "projects/#{project_id}/translations",
      req: { query: cursor_params.merge(cursor: 'eyIxIjoyNjU4ODM0NDUzfQ==') },
      resp: {
        body: fixture('translations/translations_cursor_2'),
        headers: { 'x-pagination-limit': cursor_params[:limit] }
      }
    )

    translations = test_client.translations project_id, cursor_params

    expect(translations.collection.length).to eq(2)
    expect(translations[0].translation_id).to eq(2_574_122_386)
    expect_to_have_valid_resources(translations)
    expect(translations.next_page?).to be false
    expect(translations.prev_page?).to be false
    expect(translations.next_cursor?).to be true
    expect(translations.next_cursor).to eq('eyIxIjoyNjU4ODM0NDUzfQ==')

    expect(translations.prev_page).to be_nil
    expect(translations.next_page).to be_nil

    next_cursor_translations = translations.load_next_cursor

    expect(next_cursor_translations.collection.length).to eq(2)
    expect(next_cursor_translations[0].translation_id).to eq(2_658_834_453)
    expect(next_cursor_translations.next_page?).to be false
    expect(next_cursor_translations.prev_page?).to be false
    expect(next_cursor_translations.next_cursor?).to be false
    expect(next_cursor_translations.next_cursor).to be_nil

    expect(next_cursor_translations.load_next_cursor).to be_nil
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
