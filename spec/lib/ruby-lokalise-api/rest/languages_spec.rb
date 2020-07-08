# frozen_string_literal: true

RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:language_id) { 640 }
  let(:new_language_id) { 894 }

  describe '#system_languages' do
    it 'returns all system languages' do
      languages = VCR.use_cassette('all_system_languages') do
        test_client.system_languages
      end.collection

      expect(languages.count).to eq(100)
      expect(languages.first.lang_iso).to eq('ab')
    end

    it 'supports pagination' do
      languages = VCR.use_cassette('all_system_languages_pagination') do
        test_client.system_languages limit: 10, page: 3
      end

      expect(languages.collection.count).to eq(10)
      expect(languages.total_results).to eq(618)
      expect(languages.total_pages).to eq(62)
      expect(languages.results_per_page).to eq(10)
      expect(languages.current_page).to eq(3)
    end
  end

  describe '#project_languages' do
    it 'returns all project languages' do
      languages = VCR.use_cassette('all_project_languages') do
        test_client.project_languages project_id
      end.collection

      expect(languages.count).to eq(3)
      expect(languages.first.lang_iso).to eq('en')
    end

    it 'supports pagination' do
      languages = VCR.use_cassette('all_project_languages_pagination') do
        test_client.project_languages project_id, limit: 1, page: 2
      end

      expect(languages.collection.count).to eq(1)
      expect(languages.total_results).to eq(3)
      expect(languages.total_pages).to eq(3)
      expect(languages.results_per_page).to eq(1)
      expect(languages.current_page).to eq(2)
    end
  end

  specify '#language' do
    language = VCR.use_cassette('language') do
      test_client.language project_id, language_id
    end

    expect(language.lang_id).to eq(language_id)
    expect(language.lang_iso).to eq('en')
    expect(language.lang_name).to eq('English')
    expect(language.is_rtl).to eq(false)
    expect(language.plural_forms).to eq(%w[one other])
  end

  specify '#reload_data' do
    language = VCR.use_cassette('language') do
      test_client.language project_id, language_id
    end

    reloaded_language = VCR.use_cassette('language') do
      language.reload_data
    end

    expect(reloaded_language.lang_id).to eq(language.lang_id)
  end

  specify '#create_languages' do
    language = VCR.use_cassette('create_languages') do
      test_client.create_languages project_id, lang_iso: 'ab', custom_name: 'rspec lang'
    end.collection.first

    expect(language.lang_name).to eq('rspec lang')
    expect(language.lang_iso).to eq('ab')
  end

  specify '#update_language' do
    language = VCR.use_cassette('update_language') do
      test_client.update_language project_id, new_language_id, lang_name: 'updated lang',
                                                               plural_forms: %w[one]
    end

    expect(language.lang_name).to eq('updated lang')
    expect(language.lang_iso).to eq('ab')
    expect(language.plural_forms).to eq(%w[one])
  end

  specify '#destroy_language' do
    response = VCR.use_cassette('delete_language') do
      test_client.destroy_language project_id, new_language_id
    end
    expect(response['project_id']).to eq(project_id)
    expect(response['language_deleted']).to eq(true)
  end

  context 'when project language methods are chained' do
    it 'supports update and destroy' do
      language = VCR.use_cassette('create_another_language') do
        test_client.create_languages project_id, lang_iso: 'ab', custom_name: 'chained lang'
      end.collection.first

      expect(language.client).to eq(test_client)
      expect(language.lang_name).to eq('chained lang')

      path = language.path

      updated_language = VCR.use_cassette('update_language_chained') do
        language.update lang_name: 'updated!'
      end

      expect(updated_language.client).to eq(test_client)
      expect(updated_language.lang_name).to eq('updated!')
      expect(updated_language.lang_id).to eq(language.lang_id)
      expect(updated_language.path).to eq(path)

      delete_response = VCR.use_cassette('delete_language_chained') do
        updated_language.destroy
      end

      expect(delete_response['project_id']).to eq(project_id)
      expect(delete_response['language_deleted']).to eq(true)
    end
  end
end
