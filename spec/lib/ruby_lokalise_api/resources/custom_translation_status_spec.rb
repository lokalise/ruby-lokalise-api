# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::CustomTranslationStatus do
  let(:status_fixture) { loaded_fixture('cts/status') }

  let(:project_id) { status_fixture['project_id'] }

  let(:status_endpoint) do
    params = { query: [project_id, status_fixture['custom_translation_status']['status_id']] }
    endpoint name: 'CustomTranslationStatuses', client: test_client, params: params
  end

  let(:status) do
    resource 'CustomTranslationStatus', response(status_fixture, status_endpoint)
  end

  let(:status_id) { status.status_id }

  specify '#reload_data' do
    stub(
      uri: "projects/#{project_id}/custom_translation_statuses/#{status_id}",
      resp: { body: fixture('cts/status') }
    )

    reloaded_status = status.reload_data

    expect(reloaded_status.status_id).to eq(status_id)
    expect(reloaded_status.project_id).to eq(project_id)
  end

  specify '#update' do
    data = {
      title: 'ruby3'
    }

    stub(
      uri: "projects/#{project_id}/custom_translation_statuses/#{status_id}",
      req: { body: data, verb: :put },
      resp: { body: fixture('cts/update_status2') }
    )

    updated_status = status.update data

    expect(updated_status).to be_an_instance_of(described_class)
    expect(updated_status.status_id).to eq(status_id)
    expect(updated_status.title).to eq(data[:title])
  end

  specify '#destroy' do
    stub(
      uri: "projects/#{project_id}/custom_translation_statuses/#{status_id}",
      req: { verb: :delete },
      resp: { body: fixture('cts/destroy_status2') }
    )

    res = test_client.destroy_custom_translation_status project_id, status_id

    expect(res.project_id).to eq(project_id)
    expect(res.branch).to eq('master')
    expect(res.custom_translation_status_deleted).to be true
  end
end
