RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:webhook_id) { 'c7eb7e6e3c2fb2b26d0b64d0de083a5a71675b3d' }
  let(:new_webhook_id) { 'b345ccc6499920c490e8f4fe9487b1378dbf1dbf' }

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
end
