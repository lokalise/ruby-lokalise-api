# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Segments do
  let(:project_id) { '7451498664b95d6111c812.34468173' }
  let(:key_id) { 353_507_573 }
  let(:lang_iso) { 'en' }
  let(:segment_number) { 1 }

  specify '#segments' do
    stub(
      uri: "projects/#{project_id}/keys/#{key_id}/segments/#{lang_iso}",
      resp: { body: fixture('segments/segments') }
    )

    segments = test_client.segments project_id, key_id, lang_iso

    expect(segments.collection.length).to eq(5)
    expect_to_have_valid_resources(segments)
    expect(segments.project_id).to eq(project_id)
    expect(segments.key_id).to eq(key_id)
    expect(segments.language_iso).to eq(lang_iso)

    segment = segments[0]

    expect(segment.segment_number).to eq(segment_number)
  end

  specify '#segment' do
    stub(
      uri: "projects/#{project_id}/keys/#{key_id}/segments/#{lang_iso}/#{segment_number}?disable_references=1",
      resp: { body: fixture('segments/segment') }
    )

    segment = test_client.segment project_id, key_id, lang_iso, segment_number, disable_references: 1

    expect(segment.project_id).to eq(project_id)
    expect(segment.key_id).to eq(key_id)
    expect(segment.language_iso).to eq(lang_iso)
    expect(segment.segment_number).to eq(segment_number)
    expect(segment.value).to eq('This is a text.')
    expect(segment.modified_by).to eq(20_181)
    expect(segment.modified_by_email).to eq('bodrovis@protonmail.com')
    expect(segment.modified_at).to eq('2023-07-20 16:14:48 (Etc/UTC)')
    expect(segment.modified_at_timestamp).to eq(1_689_869_688)
    expect(segment.is_reviewed).to be false
    expect(segment.reviewed_by).to eq(0)
    expect(segment.is_fuzzy).to be false
    expect(segment.words).to eq(4)
    expect(segment.custom_translation_statuses).to eq([])
  end

  specify '#update_segment' do
    segment_data = {
      value: 'Updated.',
      is_fuzzy: false
    }

    stub(
      uri: "projects/#{project_id}/keys/#{key_id}/segments/#{lang_iso}/#{segment_number}",
      req: { body: segment_data, verb: :put },
      resp: { body: fixture('segments/update_segment') }
    )

    segment = test_client.update_segment project_id, key_id, lang_iso, segment_number, segment_data

    expect(segment.project_id).to eq(project_id)
    expect(segment.key_id).to eq(key_id)
    expect(segment.value).to eq(segment_data[:value])
    expect(segment.is_fuzzy).to eq(segment_data[:is_fuzzy])
  end
end
