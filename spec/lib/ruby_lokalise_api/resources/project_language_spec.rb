# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::ProjectLanguage do
  let(:project_id) { '88628569645b945648b474.25982965' }

  let(:loaded_langs_fixture) { loaded_fixture('languages/project_languages') }

  let(:languages) do
    collection 'ProjectLanguages', response(loaded_langs_fixture, lang_endpoint)
  end

  let(:lang_endpoint) do
    params = { query: project_id }
    endpoint name: 'ProjectLanguages', client: test_client, params: params
  end

  specify '#reload_data' do
    language = languages[2]

    stub(
      uri: "projects/#{project_id}/languages/#{language.lang_id}",
      resp: { body: fixture('languages/project_language') }
    )

    reloaded_lang = language.reload_data

    expect(reloaded_lang).to be_an_instance_of(described_class)
    expect(reloaded_lang.lang_id).to eq(language.lang_id)
  end

  specify '#update' do
    language = languages[2]

    lang_data = {
      lang_name: 'French (updated)'
    }

    stub(
      uri: "projects/#{project_id}/languages/#{language.lang_id}",
      req: { body: lang_data, verb: :put },
      resp: { body: fixture('languages/update_project_language') }
    )

    updated_lang = language.update lang_data

    expect(updated_lang).to be_an_instance_of(described_class)
    expect(updated_lang.lang_name).to eq(lang_data[:lang_name])
    expect(updated_lang.lang_id).to eq(language.lang_id)
  end

  specify '#destroy' do
    language = languages[0]

    stub(
      uri: "projects/#{project_id}/languages/#{language.lang_id}",
      req: { verb: :delete },
      resp: { body: fixture('languages/destroy_language') }
    )

    resp = language.destroy

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.branch).to eq('master')
    expect(resp.language_deleted).to be true
  end
end
