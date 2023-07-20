# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Webhooks do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:webhook_id) { 'b47d698677ba426854ceee2982fe304d84c547f4' }

  specify '#webhooks' do
    stub(
      uri: "projects/#{project_id}/webhooks",
      resp: { body: fixture('webhooks/webhooks') }
    )

    webhooks = test_client.webhooks project_id

    expect(webhooks.collection.length).to eq(3)
    expect_to_have_valid_resources(webhooks)
    expect(webhooks.project_id).to eq(project_id)

    webhook = webhooks[0]

    expect(webhook.webhook_id).to eq(webhook_id)
  end

  specify '#webhook' do
    stub(
      uri: "projects/#{project_id}/webhooks/#{webhook_id}",
      resp: { body: fixture('webhooks/webhook') }
    )

    webhook = test_client.webhook project_id, webhook_id

    expect(webhook.webhook_id).to eq(webhook_id)
    expect(webhook.project_id).to eq(project_id)
    expect(webhook.url).to include('https://bodrovis')
    expect(webhook.branch).to be_nil
    expect(webhook.secret).to include('baa11')
    expect(webhook.events).to include('project.translation.proofread')
    expect(webhook.event_lang_map[0]['event']).to eq('project.translation.proofread')
  end

  specify '#create_webhook' do
    webhook_data = {
      url: 'https://bodrovis.tech/lokalise',
      events: %w[project.snapshot project.branch.merged]
    }

    stub(
      uri: "projects/#{project_id}/webhooks",
      req: { body: webhook_data, verb: :post },
      resp: { body: fixture('webhooks/create_webhook') }
    )

    webhook = test_client.create_webhook project_id, webhook_data

    expect(webhook).to be_an_instance_of(RubyLokaliseApi::Resources::Webhook)
    expect(webhook.url).to eq(webhook_data[:url])
    expect(webhook.events).to include(*webhook_data[:events])
  end

  specify '#update_webhook' do
    webhook_data = {
      events: %w[project.exported]
    }

    stub(
      uri: "projects/#{project_id}/webhooks/#{webhook_id}",
      req: { body: webhook_data, verb: :put },
      resp: { body: fixture('webhooks/update_webhook') }
    )

    webhook = test_client.update_webhook project_id, webhook_id, webhook_data

    expect(webhook).to be_an_instance_of(RubyLokaliseApi::Resources::Webhook)
    expect(webhook.webhook_id).to eq(webhook_id)
    expect(webhook.events).to eq(webhook_data[:events])
  end

  specify '#regenerate_webhook_secret' do
    stub(
      uri: "projects/#{project_id}/webhooks/#{webhook_id}/secret/regenerate",
      req: { verb: :patch },
      resp: { body: fixture('webhooks/regenerate_webhook_secret') }
    )

    response = test_client.regenerate_webhook_secret project_id, webhook_id

    expect(response).to be_an_instance_of(RubyLokaliseApi::Generics::RegeneratedWebhookSecret)
    expect(response.project_id).to eq(project_id)
    expect(response.secret).to include('70fb')
  end

  specify '#destroy_webhook' do
    stub(
      uri: "projects/#{project_id}/webhooks/#{webhook_id}",
      req: { verb: :delete },
      resp: { body: fixture('webhooks/destroy_webhook') }
    )

    resp = test_client.destroy_webhook project_id, webhook_id

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.webhook_deleted).to be true
  end
end
