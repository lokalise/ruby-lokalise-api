# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::GlossaryTerms do
  let(:project_id) { '6504960967ab53d45e0ed7.15877499' }
  let(:cursor_params) do
    {
      cursor: '5319746',
      pagination: 'cursor',
      limit: 2
    }
  end
  let(:cursor_headers) do
    {
      'x-pagination-next-cursor': '5489103'
    }
  end

  it 'supports cursor pagination' do
    stub(
      uri: "projects/#{project_id}/glossary-terms",
      req: { query: cursor_params },
      resp: {
        body: fixture('glossary_terms/glossary_terms'),
        headers: cursor_headers
      }
    )

    stub(
      uri: "projects/#{project_id}/glossary-terms",
      req: { query: cursor_params.merge(cursor: '5489103') },
      resp: {
        body: fixture('glossary_terms/glossary_terms_cursor')
      }
    )

    glossary_terms = test_client.glossary_terms project_id, cursor_params

    expect(glossary_terms.collection.length).to eq(2)
    expect(glossary_terms[0].term).to eq('router')
    expect_to_have_valid_resources(glossary_terms)
    expect(glossary_terms.next_page?).to be false
    expect(glossary_terms.prev_page?).to be false
    expect(glossary_terms.next_cursor?).to be true
    expect(glossary_terms.next_cursor).to eq('5489103')

    expect(glossary_terms.prev_page).to be_nil
    expect(glossary_terms.next_page).to be_nil

    next_cursor_terms = glossary_terms.load_next_cursor

    expect(next_cursor_terms.collection.length).to eq(1)
    expect(next_cursor_terms[0].term).to eq('sample')
    expect(next_cursor_terms.next_page?).to be false
    expect(next_cursor_terms.prev_page?).to be false
    expect(next_cursor_terms.next_cursor?).to be false
    expect(next_cursor_terms.next_cursor).to be_nil

    expect(next_cursor_terms.load_next_cursor).to be_nil
  end
end
