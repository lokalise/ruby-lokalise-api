# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Languages do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:language_id) { 673 }

  let(:pagination_headers) do
    {
      'x-pagination-total-count': '687',
      'x-pagination-page-count': '229',
      'x-pagination-limit': '3',
      'x-pagination-page': '1'
    }
  end

  specify '#system_languages' do
    pagination_params = { page: 1, limit: 3 }

    stub(
      uri: 'system/languages',
      req: { query: pagination_params },
      resp: {
        body: fixture('languages/system_languages_page1'),
        headers: pagination_headers
      }
    )

    sys_langs = test_client.system_languages pagination_params

    expect(sys_langs.current_page).to eq(1)
    expect(sys_langs.prev_page?).to be false
    expect_to_have_valid_resources(sys_langs)

    lang = sys_langs[0]

    expect(lang.lang_name).to eq('Abkhaz')
    expect(lang.lang_iso).to eq('ab')

    stub(
      uri: 'system/languages',
      req: { query: pagination_params.merge(page: 2) },
      resp: {
        body: fixture('languages/system_languages_page2'),
        headers: pagination_headers.merge({ 'x-pagination-page': '2' })
      }
    )

    sys_langs_next = sys_langs.next_page

    expect(sys_langs_next.current_page).to eq(2)
    expect_to_have_valid_resources(sys_langs_next)
    expect(sys_langs_next[0].lang_name).to eq('Afrikaans (Namibia)')
  end

  specify '#project_languages' do
    stub(
      uri: "projects/#{project_id}/languages",
      resp: { body: fixture('languages/project_languages') }
    )

    project_langs = test_client.project_languages project_id

    expect_to_have_valid_resources(project_langs)

    expect(project_langs.project_id).to eq(project_id)
    expect(project_langs.branch).to eq('master')

    project_lang = project_langs[0]

    expect(project_lang.lang_id).to eq(10_001)
    expect(project_lang.project_id).to eq(project_id)
  end

  specify '#project_language' do
    stub(
      uri: "projects/#{project_id}/languages/#{language_id}",
      resp: { body: fixture('languages/project_language') }
    )

    language = test_client.project_language project_id, language_id

    expect(language.project_id).to eq(project_id)
    expect(language.branch).to eq('master')
    expect(language.lang_id).to eq(language_id)
    expect(language.lang_iso).to eq('fr')
    expect(language.lang_name).to eq('French')
    expect(language.is_rtl).to be false
    expect(language.plural_forms).to include('other')
  end

  specify '#create_project_languages' do
    body = [{
      lang_iso: 'de'
    }, {
      lang_iso: 'nl'
    }]

    stub(
      uri: "projects/#{project_id}/languages",
      req: { body: { languages: body }, verb: :post },
      resp: { body: fixture('languages/create_project_languages') }
    )

    languages = test_client.create_project_languages project_id, body

    expect(languages).to be_an_instance_of(RubyLokaliseApi::Collections::ProjectLanguages)
    expect_to_have_valid_resources(languages)
    expect(languages.project_id).to eq(project_id)
    expect(languages[0].lang_iso).to eq('de')
  end

  specify '#update_project_language' do
    lang_data = {
      lang_name: 'French (updated)'
    }

    stub(
      uri: "projects/#{project_id}/languages/#{language_id}",
      req: { body: lang_data, verb: :put },
      resp: { body: fixture('languages/update_project_language') }
    )

    lang = test_client.update_project_language project_id, language_id, lang_data

    expect(lang).to be_an_instance_of(RubyLokaliseApi::Resources::ProjectLanguage)
    expect(lang.lang_name).to eq(lang_data[:lang_name])
    expect(lang.lang_id).to eq(language_id)
  end

  specify '#destroy_project_language' do
    stub(
      uri: "projects/#{project_id}/languages/#{language_id}",
      req: { verb: :delete },
      resp: { body: fixture('languages/destroy_language') }
    )

    resp = test_client.destroy_project_language project_id, language_id

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.branch).to eq('master')
    expect(resp.language_deleted).to be true
  end
end
