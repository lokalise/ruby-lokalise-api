# frozen_string_literal: true

RSpec.describe Lokalise::Client do
  let(:project_id) { '39066161618d4ecb9fdc12.00274309' }
  let(:key_id) { 129_358_815 }

  describe '#segments' do
    it 'returns all segments for a key under lang_iso' do
      segments = VCR.use_cassette('all_key_segments') do
        test_client.segments project_id, key_id, 'en'
      end.collection

      expect(segments.count).to eq(4)
      expect(segments.first.value).to eq('Hello!')
    end
  end

  describe '#segment' do
    it 'returns a single segment' do
      lang_iso = 'en'
      segment_number = 2

      segment = VCR.use_cassette('key_segment') do
        test_client.segment project_id, key_id, lang_iso, segment_number
      end

      expect(segment.key_id).to eq(key_id)
      expect(segment.segment_number).to eq(segment_number)
      expect(segment.language_iso).to eq(lang_iso)
      expect(segment.modified_at).to eq('2021-11-22 16:46:50 (Etc/UTC)')
      expect(segment.modified_at_timestamp).to eq(1_637_599_610)
      expect(segment.modified_by).to eq(20_181)
      expect(segment.modified_by_email).to eq('bodrovis@protonmail.com')
      expect(segment.value).to eq('This is just a simple text.')
      expect(segment.is_fuzzy).to eq(false)
      expect(segment.is_reviewed).to eq(false)
      expect(segment.reviewed_by).to eq(0)
      expect(segment.words).to eq(6)
      expect(segment.custom_translation_statuses.first['color']).to eq('#61bd4f')
    end

    it 'allows to pass params' do
      lang_iso = 'en'
      segment_number = 2

      segment = VCR.use_cassette('key_segment_params') do
        test_client.segment project_id, key_id, lang_iso, segment_number, disable_references: '1'
      end

      expect(segment.segment_number).to eq(segment_number)
      expect(segment.value).to eq('This is just a simple text.')
      expect(segment.language_iso).to eq(lang_iso)
    end
  end

  specify '#update_segment' do
    lang_iso = 'en'
    segment_number = 3

    segment = VCR.use_cassette('update_key_segment') do
      test_client.update_segment project_id, key_id, lang_iso, segment_number,
                                 value: 'Updated via API',
                                 is_reviewed: true
    end

    expect(segment.segment_number).to eq(segment_number)
    expect(segment.value).to eq('Updated via API')
    expect(segment.language_iso).to eq(lang_iso)
  end

  context 'when segment methods are chained' do
    specify '#reload_data' do
      lang_iso = 'en'
      segment_number = 2

      segment = VCR.use_cassette('key_segment') do
        test_client.segment project_id, key_id, lang_iso, segment_number
      end

      reloaded_segment = VCR.use_cassette('reload_key_segment') do
        segment.reload_data
      end

      expect(reloaded_segment.segment_number).to eq(segment_number)
      expect(reloaded_segment.key_id).to eq(key_id)
    end

    specify '#update' do
      lang_iso = 'en'
      segment_number = 4

      segment = VCR.use_cassette('another_key_segment') do
        test_client.segment project_id, key_id, lang_iso, segment_number
      end

      updated_segment = VCR.use_cassette('update_key_segment_chained') do
        segment.update value: 'Chain Updated',
                       is_fuzzy: true
      end

      expect(updated_segment.segment_number).to eq(segment_number)
      expect(updated_segment.is_fuzzy).to eq(true)
      expect(updated_segment.value).to eq('Chain Updated')
    end
  end
end
