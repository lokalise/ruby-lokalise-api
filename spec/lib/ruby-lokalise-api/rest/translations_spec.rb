RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:translation_id) { 80_015_147 }

  describe '#translations' do
    it 'should return all translations' do
      translations = VCR.use_cassette('translations') do
        test_client.translations project_id
      end.collection

      expect(translations.count).to eq(9)
    end

    it 'should support pagination' do
      translations = VCR.use_cassette('all_translations_pagination') do
        test_client.translations project_id, limit: 4, page: 2
      end

      expect(translations.collection.count).to eq(4)
      expect(translations.total_results).to eq(9)
      expect(translations.total_pages).to eq(3)
      expect(translations.results_per_page).to eq(4)
      expect(translations.current_page).to eq(2)
    end
  end

  specify '#translation' do
    translation = VCR.use_cassette('translation') do
      test_client.translation project_id, translation_id
    end

    expect(translation.translation_id).to eq(translation_id)
    expect(translation.key_id).to eq(15_571_975)
    expect(translation.language_iso).to eq('en')
    expect(translation.modified_at).to eq('2018-12-10 19:04:08 (Etc/UTC)')
    expect(translation.modified_by).to eq(20_181)
    expect(translation.modified_by_email).to eq('bodrovis@protonmail.com')
    expect(translation.translation).to eq('rspec trans')
    expect(translation.is_fuzzy).to eq(false)
    expect(translation.is_reviewed).to eq(true)
    expect(translation.words).to eq(2)
  end

  specify '#update_translation' do
    translation = VCR.use_cassette('update_translation') do
      test_client.update_translation project_id, translation_id, translation: 'rspec trans',
                                                                 is_reviewed: true
    end

    expect(translation.translation_id).to eq(translation_id)
    expect(translation.translation).to eq('rspec trans')
    expect(translation.is_reviewed).to eq(true)
  end
end
