# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Webhook do
  let(:project_id) { '88628569645b945648b474.25982965' }

  let(:loaded_webhook_fixture) { loaded_fixture('webhooks/webhook') }

  let(:webhook_id) { loaded_webhook_fixture['webhook']['webhook_id'] }

  let(:webhook_endpoint) do
    endpoint name: 'Webhooks', client: test_client, params: { query: [project_id, webhook_id] }
  end

  let(:webhook) do
    resource 'Webhook', response(loaded_webhook_fixture, webhook_endpoint)
  end

  specify '#reload_data' do
    stub(
      uri: "projects/#{project_id}/webhooks/#{webhook_id}",
      resp: { body: fixture('webhooks/webhook') }
    )

    reloaded_webhook = webhook.reload_data

    expect(reloaded_webhook.webhook_id).to eq(webhook_id)
  end

  specify '#update' do
    webhook_data = {
      events: %w[project.exported]
    }

    stub(
      uri: "projects/#{project_id}/webhooks/#{webhook_id}",
      req: { body: webhook_data, verb: :put },
      resp: { body: fixture('webhooks/update_webhook') }
    )

    updated_webhook = webhook.update webhook_data

    expect(updated_webhook).to be_an_instance_of(described_class)
    expect(updated_webhook.webhook_id).to eq(webhook_id)
    expect(updated_webhook.events).to eq(webhook_data[:events])
  end

  specify '#regenerate_secret' do
    stub(
      uri: "projects/#{project_id}/webhooks/#{webhook_id}/secret/regenerate",
      req: { verb: :patch },
      resp: { body: fixture('webhooks/regenerate_webhook_secret') }
    )

    response = webhook.regenerate_secret

    expect(response).to be_an_instance_of(RubyLokaliseApi::Generics::RegeneratedWebhookSecret)
    expect(response.project_id).to eq(project_id)
    expect(response.secret).to include('70fb')
  end

  specify '#destroy' do
    stub(
      uri: "projects/#{project_id}/webhooks/#{webhook_id}",
      req: { verb: :delete },
      resp: { body: fixture('webhooks/destroy_webhook') }
    )

    resp = webhook.destroy

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.webhook_deleted).to be true
  end
end
