# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::GlossaryTerm do
  let(:loaded_term_fixture) { loaded_fixture('glossary_terms/glossary_term') }

  let(:project_id) { '6504960967ab53d45e0ed7.15877499' }

  let(:term_endpoint) do
    params = { query: [project_id, loaded_term_fixture['data']['id']] }
    endpoint name: 'GlossaryTerms', client: test_client, params: params
  end

  let(:glossary_term) do
    resource 'GlossaryTerm', response(loaded_term_fixture, term_endpoint)
  end

  let(:term_id) { 5319746 }

  specify '#reload_data' do
    stub(
      uri: "projects/#{project_id}/glossary-terms/#{term_id}",
      resp: { body: fixture('glossary_terms/glossary_term') }
    )

    reloaded_term = glossary_term.reload_data

    expect(reloaded_term.id).to eq(term_id)
    expect(reloaded_term.term).to eq('router')
  end

  it 'does not support update' do
    expect(glossary_term).not_to respond_to(:update)
  end

  it 'does not support destroy' do
    expect(glossary_term).not_to respond_to(:destroy)
  end
end