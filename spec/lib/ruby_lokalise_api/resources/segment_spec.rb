# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Segment do
  let(:project_id) { '7451498664b95d6111c812.34468173' }

  let(:segment_f) { loaded_fixture('segments/segment') }
  let(:segment_number) { segment_f['segment']['segment_number'] }
  let(:segment_endpoint) do
    endpoint name: 'Segments', client: test_client, params: {
      query: [project_id, segment_f['key_id'], segment_f['language_iso'], segment_number]
    }
  end

  let(:segment) do
    resource 'Segment', response(segment_f, segment_endpoint)
  end

  specify '#reload_data' do
    stub(
      uri: "projects/#{project_id}/keys/#{segment_f['key_id']}/segments/#{segment_f['language_iso']}/#{segment_number}",
      resp: { body: fixture('segments/segment') }
    )

    reloaded_segment = segment.reload_data

    expect(reloaded_segment.segment_number).to eq(segment_number)
  end

  specify '#update' do
    segment_data = {
      value: 'Updated.',
      is_fuzzy: false
    }

    stub(
      uri: "projects/#{project_id}/keys/#{segment_f['key_id']}/segments/#{segment_f['language_iso']}/#{segment_number}",
      req: { body: segment_data, verb: :put },
      resp: { body: fixture('segments/update_segment') }
    )

    updated_segment = segment.update segment_data

    expect(updated_segment).to be_an_instance_of(described_class)
    expect(updated_segment.value).to eq(segment_data[:value])
    expect(updated_segment.is_fuzzy).to eq(segment_data[:is_fuzzy])
  end

  it 'does not support' do
    expect(segment).not_to respond_to(:destroy)
  end
end
