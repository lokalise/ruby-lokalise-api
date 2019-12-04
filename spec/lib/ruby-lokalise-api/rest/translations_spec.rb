RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:translation_id) { 80_015_147 }
  let(:another_translation_id) { 82_070_312 }

  describe '#translations' do
    it 'returns all translations' do
      translations = VCR.use_cassette('translations') do
        test_client.translations project_id
      end.collection

      expect(translations.count).to eq(9)
    end

    it 'supports pagination' do
      translations = VCR.use_cassette('all_translations_pagination') do
        test_client.translations project_id, limit: 4, page: 2, disable_references: 0,
                                             filter_is_reviewed: 0
      end

      expect(translations.collection.count).to eq(4)
      expect(translations.total_results).to eq(187)
      expect(translations.total_pages).to eq(47)
      expect(translations.results_per_page).to eq(4)
      expect(translations.current_page).to eq(2)
      expect(translations.request_params[:page]).to eq(2)
      expect(translations.request_params[:disable_references]).to eq(0)
      expect(translations.request_params[:filter_is_reviewed]).to eq(0)

      next_page_trans = VCR.use_cassette('translations_next_page') do
        translations.next_page
      end

      expect(next_page_trans).to be_an_instance_of(Lokalise::Collections::Translation)
      expect(next_page_trans.client).to be_an_instance_of(described_class)
      expect(next_page_trans.request_params[:page]).to eq(3)
      expect(next_page_trans.request_params[:disable_references]).to eq(0)
      expect(next_page_trans.total_results).to eq(187)
      expect(next_page_trans.current_page).to eq(3)
      expect(next_page_trans.next_page?).to eq(true)
      expect(next_page_trans.prev_page?).to eq(true)

      prev_page_trans = VCR.use_cassette('translations_prev_page') do
        translations.prev_page
      end

      expect(prev_page_trans).to be_an_instance_of(Lokalise::Collections::Translation)
      expect(prev_page_trans.client).to be_an_instance_of(described_class)
      expect(prev_page_trans.request_params[:page]).to eq(1)
      expect(next_page_trans.request_params[:disable_references]).to eq(0)
      expect(prev_page_trans.total_results).to eq(187)
      expect(prev_page_trans.current_page).to eq(1)
      expect(prev_page_trans.next_page?).to eq(true)
      expect(prev_page_trans.prev_page?).to eq(false)
    end
  end

  specify '#translation' do
    translation = VCR.use_cassette('translation') do
      test_client.translation project_id, translation_id
    end

    expect(translation.translation_id).to eq(translation_id)
    expect(translation.key_id).to eq(15_571_975)
    expect(translation.language_iso).to eq('en')
    expect(translation.modified_at).to eq('2019-03-26 16:41:31 (Etc/UTC)')
    expect(translation.modified_at_timestamp).to eq(1_553_618_491)
    expect(translation.modified_by).to eq(20_181)
    expect(translation.modified_by_email).to eq('bodrovis@protonmail.com')
    expect(translation.translation).to eq('RSpec is a testing suite')
    expect(translation.is_fuzzy).to eq(false)
    expect(translation.is_reviewed).to eq(false)
    expect(translation.words).to eq(5)
    expect(translation.custom_translation_statuses).to eq([])
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

  context 'when translation chained methods are used' do
    it 'supports update' do
      translation = VCR.use_cassette('another_translation') do
        test_client.translation project_id, another_translation_id
      end

      updated_translation = VCR.use_cassette('update_translation_chained') do
        translation.update translation: 'chained updated'
      end

      expect(updated_translation.client).to eq(test_client)
      expect(updated_translation.translation).to eq('chained updated')
      expect(updated_translation.translation_id).to eq(translation.translation_id)
    end
  end
end
