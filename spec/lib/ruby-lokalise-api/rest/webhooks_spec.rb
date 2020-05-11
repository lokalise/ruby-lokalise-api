# frozen_string_literal: true

RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:webhook_id) { 'c7eb7e6e3c2fb2b26d0b64d0de083a5a71675b3d' }
  let(:new_webhook_id) { 'b345ccc6499920c490e8f4fe9487b1378dbf1dbf' }
  let(:serious_webhook_id) { '795565582e5ab15a59bb68156c7e2e9eaa1e8d1a' }

  describe '#webhooks' do
    it 'returns all webhooks' do
      webhooks = VCR.use_cassette('webhooks') do
        test_client.webhooks project_id
      end.collection

      expect(webhooks.count).to eq(3)
      expect(webhooks.first.url).to eq('https://serios.webhook')
    end

    it 'supports pagination' do
      webhooks = VCR.use_cassette('all_webhooks_pagination') do
        test_client.webhooks project_id, limit: 1, page: 2
      end

      expect(webhooks.collection.count).to eq(1)
      expect(webhooks.total_results).to eq(3)
      expect(webhooks.total_pages).to eq(3)
      expect(webhooks.results_per_page).to eq(1)
      expect(webhooks.current_page).to eq(2)
    end
  end

  specify '#webhook' do
    webhook = VCR.use_cassette('webhook') do
      test_client.webhook project_id, webhook_id
    end

    expect(webhook.webhook_id).to eq(webhook_id)
    expect(webhook.url).to eq('https://canihaz.hook')
    expect(webhook.secret).to eq('a62450cd9eeca8dfc84f3c0cf9b7a6a370267d6f')
    expect(webhook.events).to include('project.snapshot')
    expect(webhook.event_lang_map.first['event']).to eq('project.translation.updated')
  end

  specify '#reload_data' do
    webhook = VCR.use_cassette('webhook') do
      test_client.webhook project_id, webhook_id
    end

    reloaded_webhook = VCR.use_cassette('webhook') do
      webhook.reload_data
    end

    expect(reloaded_webhook.webhook_id).to eq(webhook.webhook_id)
  end

  specify '#create_webhook' do
    webhook = VCR.use_cassette('create_webhook') do
      test_client.create_webhook project_id,
                                 url: 'http://thatz.ahook',
                                 events: ['project.imported', 'project.exported']
    end

    expect(webhook.webhook_id).to eq(new_webhook_id)
    expect(webhook.url).to eq('http://thatz.ahook')
    expect(webhook.events).to include('project.imported', 'project.exported')
  end

  specify '#update_webhook' do
    webhook = VCR.use_cassette('update_webhook') do
      test_client.update_webhook project_id,
                                 new_webhook_id,
                                 url: 'http://ihaz.cheezburger'
    end

    expect(webhook.webhook_id).to eq(new_webhook_id)
    expect(webhook.url).to eq('http://ihaz.cheezburger')
    expect(webhook.events).to include('project.imported', 'project.exported')
  end

  specify '#destroy_webhook' do
    response = VCR.use_cassette('destroy_webhook') do
      test_client.destroy_webhook project_id,
                                  new_webhook_id
    end

    expect(response['project_id']).to eq(project_id)
    expect(response['webhook_deleted']).to eq(true)
  end

  specify '#regenerate_webhook_secret' do
    response = VCR.use_cassette('regenerate_webhook_secret') do
      test_client.regenerate_webhook_secret project_id,
                                            serious_webhook_id
    end

    expect(response['project_id']).to eq(project_id)
    expect(response['secret']).not_to be_nil
  end

  context 'when webhook chained methods are used' do
    it 'supports regenerate_webhook_secret' do
      webhook = VCR.use_cassette('webhook_2') do
        test_client.webhook project_id, serious_webhook_id
      end

      expect(webhook.branch).to eq('master')
      expect(webhook.webhook_id).to eq(serious_webhook_id)

      response = VCR.use_cassette('regenerate_webhook_secret_2') do
        webhook.regenerate_secret
      end

      expect(response['project_id']).to eq(project_id)
      expect(response['secret']).not_to be_nil
    end

    it 'supports update and destroy' do
      webhook = VCR.use_cassette('webhook_2') do
        test_client.webhook project_id, serious_webhook_id
      end

      expect(webhook).to respond_to(:update)
      expect(webhook).to respond_to(:destroy)
    end
  end
end
