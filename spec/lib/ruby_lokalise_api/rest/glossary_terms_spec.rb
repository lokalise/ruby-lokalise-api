# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::GlossaryTerms do
  let(:project_id) { '6504960967ab53d45e0ed7.15877499' }
  let(:term_id) { 5_319_746 }

  specify '#glossary_term' do
    stub(
      uri: "projects/#{project_id}/glossary-terms/#{term_id}",
      resp: { body: fixture('glossary_terms/glossary_term') }
    )

    glossary_term = test_client.glossary_term project_id, term_id

    expect(glossary_term).to be_an_instance_of(RubyLokaliseApi::Resources::GlossaryTerm)

    expect(glossary_term.id).to eq(term_id)
    expect(glossary_term.projectId).to eq(project_id)
    expect(glossary_term.term).to eq('router')
    expect(glossary_term.description).to eq('A network device')
    expect(glossary_term.caseSensitive).to be(false)
    expect(glossary_term.translatable).to be(true)
    expect(glossary_term.forbidden).to be(false)
    expect(glossary_term.tags).to include('sample')
    expect(glossary_term.createdAt).to eq('2025-03-31 15:01:00 (Etc/UTC)')
    expect(glossary_term.updatedAt).to be_nil

    translation = glossary_term.translations[0]
    expect(translation['langId']).to eq(597)
    expect(translation['langName']).to eq('Russian')
    expect(translation['langIso']).to eq('ru')
    expect(translation['translation']).to eq('маршрутизатор')
    expect(translation['description']).to eq('описание')
  end

  describe '#glossary_terms' do
    it 'fetches all terms' do
      stub(
        uri: "projects/#{project_id}/glossary-terms",
        resp: { body: fixture('glossary_terms/glossary_terms') }
      )

      glossary_terms = test_client.glossary_terms project_id

      expect(glossary_terms.collection.length).to eq(2)
      expect_to_have_valid_resources(glossary_terms)

      glossary_term = glossary_terms[0]

      expect(glossary_term.term).to eq('router')
    end

    it 'fetches translation with cursor' do
      cursor_params = {
        limit: 1,
        cursor: '5319746'
      }
      next_cursor = '5489103'

      stub(
        uri: "projects/#{project_id}/glossary-terms",
        req: { query: cursor_params },
        resp: {
          body: fixture('glossary_terms/glossary_terms_cursor'),
          headers: {
            'x-pagination-next-cursor': next_cursor
          }
        }
      )

      glossary_terms = test_client.glossary_terms project_id, cursor_params

      expect(glossary_terms.collection.length).to eq(cursor_params[:limit])
      expect_to_have_valid_resources(glossary_terms)

      expect(glossary_terms.next_cursor?).to be true
      expect(glossary_terms.next_cursor).to eq(next_cursor)

      glossary_term = glossary_terms[0]

      expect(glossary_term.term).to eq('sample')
    end
  end

  specify '#create_glossary_terms' do
    terms_data = [
      {
        term: 'rspec',
        description: 'rspec term',
        caseSensitive: false,
        translatable: false,
        forbidden: false
      },
      {
        term: 'rspec 2',
        description: 'rspec term 2',
        caseSensitive: true,
        translatable: true,
        forbidden: false
      }
    ]

    stub(
      uri: "projects/#{project_id}/glossary-terms",
      req: { body: { terms: terms_data }, verb: :post },
      resp: { body: fixture('glossary_terms/create_glossary_terms') }
    )

    glossary_terms = test_client.create_glossary_terms project_id, terms_data

    expect(glossary_terms).to be_an_instance_of(RubyLokaliseApi::Collections::GlossaryTerms)
    expect_to_have_valid_resources(glossary_terms)

    term = glossary_terms[0]

    expect(term.description).to eq('rspec term')
  end

  specify '#update_glossary_terms' do
    terms_data = [
      {
        id: 5_517_075,
        term: 'updated rspec'
      },
      {
        id: 5_517_076,
        description: 'updated desc'
      }
    ]

    stub(
      uri: "projects/#{project_id}/glossary-terms",
      req: { body: { terms: terms_data }, verb: :put },
      resp: { body: fixture('glossary_terms/update_glossary_terms') }
    )

    glossary_terms = test_client.update_glossary_terms project_id, terms_data

    expect(glossary_terms).to be_an_instance_of(RubyLokaliseApi::Collections::GlossaryTerms)
    expect_to_have_valid_resources(glossary_terms)

    glossary_term = glossary_terms[0]

    expect(glossary_term.term).to eq('updated rspec')
  end

  specify '#destroy_glossary_terms' do
    term_ids = %w[5517075 5517076]

    stub(
      uri: "projects/#{project_id}/glossary-terms",
      req: { body: { terms: term_ids }, verb: :delete },
      resp: { body: fixture('glossary_terms/destroy_glossary_terms') }
    )

    resp = test_client.destroy_glossary_terms project_id, term_ids

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)

    expect(resp.data['deleted']['count']).to eq(2)
  end
end
